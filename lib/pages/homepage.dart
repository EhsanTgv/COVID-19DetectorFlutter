import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String response = "request not sended";

  openCameraFunction() {
    Navigator.pushNamed<bool>(context, "/camera");
  }

  Future openGalleryFunction() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var _response =
        await uploadImage(image.path, "http://chichiapp.ir:8838/upload/x-ray");

    setState(() {
      response = _response;
    });
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filename));
    var res = await request.send();
    return res.stream.bytesToString();
  }

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
              onPressed: openCameraFunction,
              child: Text("Open Camera"),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              onPressed: openGalleryFunction,
              child: Text("Open Gallery"),
            ),
            SizedBox(
              height: 12,
            ),
            Text(response)
          ],
        ),
      ),
    );
  }
}
