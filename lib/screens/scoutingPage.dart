// scouting form

import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/homePage.dart';

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
