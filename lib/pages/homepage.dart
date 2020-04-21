import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:camera/camera.dart';

import 'take_picture_screen.dart';

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;

  MyHomePage(this.camera);

  String cameraImagePath;

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState(camera);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final CameraDescription camera;

  _MyHomePageState(this.camera);

  ProgressDialog progressDialog;
  String state = "request not sended";

  openCameraFunction() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TakePictureScreen(camera: camera)),
    );

    if (result != null) {
      prepareConnection(result);
    }
  }

  openGalleryFunction() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      prepareConnection(image.path);
    }
  }

  prepareConnection(imagePath) async {
    setState(() {
      state = "waiting...";
      progressDialog.show();
    });

    var _response =
        await uploadImage(imagePath, "http://chichiapp.ir:8838/upload/x-ray");

    setState(() {
      progressDialog.hide().whenComplete(() {
        state = parseData(_response);
      });
    });
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filename));
    var res = await request.send();
    return res.stream.bytesToString();
  }

  String parseData(String response) {
    try {
      Map<String, dynamic> jsonResponse = json.decode(response);
      if (jsonResponse['predict'] != null) {
        responseDialog(jsonResponse['predict']);
        return jsonResponse['predict'];
      } else {
        return "error parsing";
      }
    } catch (e) {
      return "error parsing";
    }
  }

  Future<void> responseDialog(response) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('server response'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('predict: $response'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);

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
          ],
        ),
      ),
    );
  }
}
