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
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
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
            Text(
              "Scouting Wizard",
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold, 
                fontStyle: FontStyle.italic,
                )
              ),
            SizedBox(height: size.height * 0.01),
            Text( 
              "A scouting app for Team 178",
              style: TextStyle(
                fontSize: size.width * 0.03,
                color: Colors.grey[700],
              )
            ),
            SizedBox(height: size.height * 0.05),
            // hawk animation
            
            // icon button 
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
                Navigator.push( 
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

// login page

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold (
      body: Container( 
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            // text 
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold, 
              )
            ),
            // username
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            // password 
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            // button
            // icon button 
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
                Navigator.push( 
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  )
                );
              },
            )
          ]
        )
      )
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
    return Scaffold (
      body: Container(
        alignment: Alignment.center,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            // text 
            Text(
              "Welcome, " + username,
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold, 
              )
            ),
          ]
        )
      )
    );
  }
}
