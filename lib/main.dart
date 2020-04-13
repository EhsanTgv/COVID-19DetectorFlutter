import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/homepage.dart';

void main() {
//  debugPaintSizeEnabled = true;
//  debugPaintBaselinesEnabled = true;
//  debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Detector',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.lightBlueAccent,
      ),
      routes: {"/": (BuildContext context) => MyHomePage()},
    );
  }
}
