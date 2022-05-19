// home page

import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/scoutingPage.dart';

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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
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
