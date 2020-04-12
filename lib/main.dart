import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      title: 'COVID-19 Detector',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.lightBlueAccent),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/": (BuildContext context) => MyHomePage(title: "COVID-19 Detector")
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
