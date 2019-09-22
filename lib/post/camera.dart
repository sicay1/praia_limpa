import 'dart:async';
import 'dart:io';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/main/index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensors/sensors.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cameraPreview.dart';

// A screen that allows users to take a picture using a given camera.
class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  int x, y, z;
  bool posicao = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();

    accelerometerEvents.listen((AccelerometerEvent event) {
      // Do something with the event.
      setState(() {
        x = event.x.round();
        y = event.y.round();
        z = event.z.round();

        if (x > 1 || y > 1 || z < 7) {
          posicao = false;
        } else if (x < -1 || y < -1 || z < 7) {
          posicao = false;
        } else {
          posicao = true;
        }
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Stack(
                children: <Widget>[
                  CameraPreview(_controller),
                  Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()),
                                (Route route) => route == null);
                      },
                      child: Container(
                        height: 30.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/back-arrow.png")
                          )
                        ),  
                      ),
                    )
                  )
                ],
              );
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () async {
            if(posicao == false){

            Fluttertoast.showToast(
                msg: "Coloque o celular na horizontal",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

          }else{
            try {
              await _initializeControllerFuture;
              final path = join(
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );
              await _controller.takePicture(path);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPreviewPage(path),
                ),
              );
            } catch (e) {
              print(e);
            }
          }
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                border: Border.all(color: CoresDoProjeto.principal, width: 2.0),
                shape: BoxShape.circle,
                color: Colors.transparent),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: CoresDoProjeto.principal, width: 1.0),
                  shape: BoxShape.circle,
                  color: posicao ? Colors.white : Colors.red,
                ),
              ),
            ),
          ),
        ));
  }
}

/*

FloatingActionButton(
        backgroundColor: posicao ? CoresDoProjeto.principal : Colors.red,
        child: Icon( posicao ? FontAwesomeIcons.camera : FontAwesomeIcons.times, color: Colors.white,),
        // Provide an onPressed callback.
        onPressed: () async {

          if(!posicao){

            final snackBar = SnackBar(
              backgroundColor: CoresDoProjeto.principal,
              content: Text('Ajuste a posição do celular para a horizontal!', style: estiloMensagem),
            );
            _scaffoldKey.currentState.showSnackBar(snackBar);

          }else{
            try {
              await _initializeControllerFuture;
              final path = join(
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );
              await _controller.takePicture(path);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPreviewPage(path),
                ),
              );
            } catch (e) {
              print(e);
            }
          }
        },
      ),

*/
