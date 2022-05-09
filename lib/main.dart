/*
main script for team 178 scouting app
*/
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/welcomePage.dart';

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
