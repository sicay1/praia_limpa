import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'postar.dart';
import '../main/index.dart';
import 'camera.dart';
import '../common/usuario.dart';

import 'package:camera/camera.dart';

class InstPage extends StatefulWidget {
  @override
  _InstPageState createState() => _InstPageState();
}

class _InstPageState extends State<InstPage> {

  List<CameraDescription> cameras;
  CameraController controller;
  bool _isReady = false;

  Future<void> _setupCameras() async {
    try {
      // initialize cameras.
      cameras = await availableCameras();
      Usuario.camera = cameras.first;
      // initialize camera controllers.
      //controller = new CameraController(cameras[0], ResolutionPreset.medium);
      //await controller.initialize();

    } on CameraException catch (_) {
      // do something on error.
    }
    //if (!isMounted) return;
    setState(() {
      _isReady = true;
    });
  }



  Future getImage() async {
      Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => CameraPage(
                                camera: Usuario.camera
                              )),
                      (Route route) => route == null); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/inst.jpg")
                  )
                ),
              ),
            )
          ],
        ),
      
    );
  }

  @override
  void initState() {
    super.initState();
    this._setupCameras();
  }
}