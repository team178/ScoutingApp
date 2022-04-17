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
            SizedBox(height: size.height * 0.05),
            ElevatedButton.icon(
              label: Text("Login"),
              icon: Icon(Icons.assignment_ind, size: 32),
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
            // upcoming matches
            ElevatedButton.icon(
              label: Text("Upcoming Matches"),
              icon: Icon(Icons.assessment_outlined, size: 32),
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
                      return MatchesPage();
                    },
                  )
                );
              },
            ),
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
                Navigator.push( 
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ScoutingPage();
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

// upcoming matches

class MatchesPage extends StatelessWidget {
  // variables
  final List<String> teams = <String>[
      "178",
      "230",
      "176"
  ]; 
  final List<String> matchNum = <String>[
      "20",
      "30",
      "40"
  ]; 
  final List<Color> colors = <Color>[
      Colors.redAccent,
      Colors.blueAccent,
      Colors.redAccent,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold ( 
      // scout button
      appBar: AppBar(title: Text('Upcoming Matches')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: teams.length,
        itemBuilder: (BuildContext context, int index) {
          return Card (
            color: colors[index],
            child: ListTile(
              title: Text(
                'Team ${teams[index]} | Match ${matchNum[index]}',
                style: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold, 
                )
              ),
            ),
          );
        }
      ) 
    );
  } 
}

// scouting form 

class ScoutingPage extends StatelessWidget {
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
              "Scouting Form",
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold, 
              )
            ),
            // team number 
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Team Number',
              ),
            ),
            // match number 
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Match Number',
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
