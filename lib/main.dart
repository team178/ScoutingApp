/*
main script for team 178 scouting app
*/
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(ScoutingApp());
}

// root

class ScoutingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScoutingWizard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomePage(),
    );
  }
}

// splash screen

// welcome page

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // text
            Text("Scouting Wizard",
                style: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                )),
            SizedBox(height: size.height * 0.01),
            Text("A scouting app for Team 178",
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: Colors.grey[700],
                )),
            SizedBox(height: size.height * 0.05),
            // hawk animation

            // button
            SizedBox(height: size.height * 0.05),
            ElevatedButton.icon(
              label: Text("Login"),
              icon: Icon(Icons.account_circle, size: 32),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(width: 1, color: Colors.grey),
                minimumSize: Size(150.0, 50.0),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}

// home page

class HomePage extends StatelessWidget {
  // variables
  final String username = "Nerd";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // text
                  Text("Welcome, " + username,
                      style: TextStyle(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      )),
                  // scout button
                  ElevatedButton.icon(
                    label: Text("Scout"),
                    icon: Icon(Icons.auto_fix_high, size: 32),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(width: 1, color: Colors.grey),
                      minimumSize: Size(150.0, 50.0),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ScoutingPage();
                        },
                      ));
                    },
                  ),
                  // sync button
                  ElevatedButton.icon(
                    label: Text("Sync"),
                    icon: Icon(Icons.all_inclusive, size: 32),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(width: 1, color: Colors.grey),
                      minimumSize: Size(150.0, 50.0),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SyncPage();
                        },
                      ));
                    },
                  )
                ])));
  }
}

// scouting form

class ScoutingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text('Scouting Form')),
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // text
                  Text("Scouting Form",
                      style: TextStyle(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      )),
                  // team number
                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Team Number',
                    ),
                  ),
                  // match number
                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Match Number',
                    ),
                  ),
                  // # of points scored
                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: '# of Points Scored',
                    ),
                  ),
                  // Other Comments
                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Other Comments',
                    ),
                  ),
                  // button
                  SizedBox(height: size.height * 0.05),
                  ElevatedButton.icon(
                    label: Text("Submit"),
                    icon: Icon(Icons.add, size: 32),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(width: 1, color: Colors.grey),
                      minimumSize: Size(150.0, 50.0),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ));
                    },
                  )
                ])));
  }
}

// sync page
class SyncPage extends StatelessWidget {
  // variables
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text('Sync')),
        body: Container(
            alignment: Alignment.center,
            child: Column(children: <Widget>[
              Text("Contributors",
                  style: TextStyle(
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Rithvik Satyavarapu",
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Patrick Brennan",
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Henry Latt",
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Andy Chen",
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Chiranswaroop Gulappa",
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Tim Barron",
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Sai Thyarla",
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: size.height * 0.05),
              /*
             ShaderMask(
             
             )
            */
              Text("you are done syncing now go scout",
                  style: TextStyle(
                    fontSize: size.width * 0.1,
                    fontWeight: FontWeight.bold,
                  )),
            ])));
  }
}
