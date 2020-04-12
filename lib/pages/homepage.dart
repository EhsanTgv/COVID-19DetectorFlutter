import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 Detector"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Open Camera"),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Open Gallery"),
            ),
          ],
        ),
      ),
    );
  }
}
