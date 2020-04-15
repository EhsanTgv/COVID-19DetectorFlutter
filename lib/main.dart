import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/homepage.dart';
import 'pages/take_picture_screen.dart';

Future<void> main() async {
//  debugPaintSizeEnabled = true;
//  debugPaintBaselinesEnabled = true;
//  debugPaintPointersEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp(this.camera);

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
      routes: {
        "/": (BuildContext context) => MyHomePage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[1] == "camera") {
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  TakePictureScreen(camera: camera));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(),
        );
      },
    );
  }
}
