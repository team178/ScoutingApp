// home page

import 'package:flutter/material.dart';

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
                  Text("Welcome, $username",
                      style: TextStyle(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      )),
                  // scout button
                  ElevatedButton.icon(
                    label: const Text("Scout"),
                    icon: const Icon(Icons.auto_fix_high, size: 32),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      minimumSize: const Size(150.0, 50.0),
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
                    label: const Text("Sync"),
                    icon: const Icon(Icons.all_inclusive, size: 32),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      minimumSize: const Size(150.0, 50.0),
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
