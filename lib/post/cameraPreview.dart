import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'postar.dart';
import '../main/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as Im;
import 'package:path/path.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as provider;


class CameraPreviewPage extends StatefulWidget {
  String image;

  CameraPreviewPage(this.image);
  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreviewPage> {

    bool enviando = false;

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 60,
        format: CompressFormat.png,
        minHeight: 600,
        minWidth: 400,


        //rotate: 180,
      );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

   iniciarPostDio(BuildContext context) async {
     var dir = await provider.getTemporaryDirectory();
     var targetPath = dir.absolute.path + "'${DateTime.now()}.png'";

     File imagemRegistro = await compressAndGetFile(new File(widget.image), targetPath);
    
    FormData formData = new FormData.from({
      "usuario": Usuario.id,
      "latitude": Usuario.lat.toString(),
      "longitude": Usuario.lon.toString(),
      "imagem": new UploadFileInfo(imagemRegistro, '${DateTime.now()}.png'), 
    });

    Dio dio = new Dio();
    String uploadURL = "${Usuario.urlBase}adicionarPostagemArquivo.php";
    

    dio.post(uploadURL, data: formData, options: Options(
      method: 'POST',
      responseType: ResponseType.json // or ResponseType.JSON
      ))
      .then((response){
        var obj = json.decode(response.toString().trim());
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PostPage(image: File(widget.image), registro: obj['id'],)));
      })
      .catchError((error) => print(error));
  }

    iniciarPost(BuildContext context) async {
     
      
      await Future.delayed(new Duration(seconds: 1));
      File imagemFile = File(widget.image);
      
      
      Im.Image image = Im.decodeImage(imagemFile.readAsBytesSync());
      Im.Image thumbnail = Im.copyResize(image, width: 480);

      String v = thumbnail.getBytes().toString();
      
      List<int> imageBytes = Im.encodePng(thumbnail);
      String base64Image = base64Encode(imageBytes);


      var res = await http.post(
        Uri.parse("${Usuario.urlBase}adicionarPostagem.php"),
        body: {
          "usuario": Usuario.id,
          "latitude": Usuario.lat.toString(),
          "longitude": Usuario.lon.toString(),
          "imagem": base64Image,
          },
        //Uri.parse("${Usuario.urlBase}adicionarUsuario.php?nome=Daniel&email=teste@teste.com&senha=12345&foto=foto"),
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);

      setState(() {
        enviando = false;
      });

      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PostPage(image: File(widget.image), registro: obj['id'],)));

      
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: 'imagemRegistro',
            child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(widget.image))
              )
            ),
          ),
          ),
          

          Positioned(
            bottom: 10.0,
            child: Container(
              width: w,
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainPage()),
                        (Route route) => route == null);
                    },
                    child: Icon(FontAwesomeIcons.times, color: Colors.red, size: 30.0,)
                  ),

                  enviando ? 
                  
                  SpinKitThreeBounce(
                              color: CoresDoProjeto.principal,
                              size: 30.0,
                              duration: Duration(milliseconds: 900),
                            ):

                  FlatButton(
                    onPressed: (){
                      setState(() {
                        enviando = true;
                        iniciarPostDio(context);
                      });
                    },
                      /*
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PostPage(image: File(widget.image))));
                          */
                    
                    child: Icon(FontAwesomeIcons.check, color: Colors.green, size: 30.0,)
                    
                    //Text("CONFIRMAR", style: TextStyle(color: Colors.green, fontSize: 17.0),),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}