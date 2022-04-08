#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

use std::fs;

use tokio::task;
use tauri::{
    api::process::{Command, CommandEvent},
    Manager,
    RunEvent,
};

use rocket::serde::{
    json::Json,
    Serialize,
    Deserialize,
};

use mongodb::bson::{doc, bson, Bson, Document};
use futures::stream::StreamExt;

#[derive(Serialize, Deserialize)]
struct Entry {
    name: String,
    id: u32,
    data: Document,
}

#[derive(Clone, serde::Serialize)]
struct Payload {
    message: String,
}


struct DB {
    client: mongodb::Client,
    window: tauri::window::Window,
}

impl DB {
    pub async fn init(window: tauri::window::Window) -> mongodb::error::Result<Self> {
        Ok(
            Self { client: mongodb::Client::with_uri_str("mongodb://localhost:27017").await?, window: window }
        )
    }
    
    pub async fn store_test(&self) -> mongodb::error::Result<()> {
        println!("{}", Bson::from("{\"test_key\":\"test_value\"}"));
        self.client.database("test").collection::<Document>("test").insert_one(bson!("{\"test_key\":\"test_value\"}").as_document().unwrap(), None).await?;
        Ok(())
    }
    
    pub async fn store_doc(&self, doc: Entry) -> mongodb::error::Result<()> {
        self.client.database("test").collection("test").insert_one(doc, None).await?;
        Ok(())
    }

}


#[rocket::post("/store", data="<data>")]
async fn index(db: &rocket::State<DB>, data: Json<Entry>) -> &'static str {
    db.store_doc(data.into_inner()).await;
    db.window.emit("card_update", Payload { message: "Stored".to_string() });
    "Hello, world!"
}

#[rocket::get("/get")]
async fn fetch(db: &rocket::State<DB>) -> Json<Vec<Document>> {
    let mut cursor = db.client.database("test").collection::<Document>("test").find(None, None).await.unwrap();
    let mut entries = Vec::new();
    while let Some(doc) = cursor.next().await {
        entries.push(doc.unwrap());
    }
    Json(entries)
}

#[rocket::main]
async fn main() {
    
    let mut app = tauri::Builder::default()
    // .on_page_load(|window, _| {
        //   println!("test");
        //   window.clone().emit("card_update", Some(Payload { message: "test".into() })).expect("failed to emit");
        // })
        .build(tauri::generate_context!())
        .expect("error while building tauri application");
        
    app.run(|app_handle, e| match e {
        RunEvent::Ready => {
            let window = app_handle.get_window("main").unwrap();
            
            let dbpath = app_handle.path_resolver().resource_dir().unwrap().join("data");
            if !dbpath.exists() {
                fs::create_dir_all(&dbpath).unwrap();
            }
            
            let (mut rx, mut child) = Command::new_sidecar("mongod")
            .expect("failed to create `mongod.exe` binary command")
            .args(&["--dbpath", dbpath.to_str().unwrap(), "--port", "27017"])
            .spawn()
            .expect("Failed to spawn mongod");
            
            task::spawn(async move{
                // read events such as stdout
                while let Some(event) = rx.recv().await {
                    match event {
                        CommandEvent::Stdout(line)  => {
                            window
                            .emit("mongod-message", Some(format!("'{}'", line)))
                            .expect("failed to emit message");
                        },
                        CommandEvent::Terminated(payload) => {
                            // TODO
                        },
                        _ => {}
                    }
                }
            });

            let window_for_events = app_handle.get_window("main").unwrap();
            
            task::spawn(async {
                let db = DB::init(window_for_events).await.unwrap();
                rocket::build()
                .mount("/", rocket::routes![index, fetch])
                .manage(db)
                .attach(
                    rocket_cors::Cors::from_options(
                        &rocket_cors::CorsOptions::default()
                    ).expect("failed to create CORS")
                )
                .launch()
                .await
                .expect("error while running rocket application");
            });
        },
        _ => (),
    });
}
    