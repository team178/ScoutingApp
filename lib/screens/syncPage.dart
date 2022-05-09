// sync page

import 'package:flutter/material.dart';

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
