// welcome page

import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/homePage.dart';

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
