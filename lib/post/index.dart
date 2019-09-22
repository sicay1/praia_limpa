import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'modal.dart';
//import 'package:location/location.dart';
import '../common/degetos.dart';
import 'tiposDegetos.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with SingleTickerProviderStateMixin {


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController animationController;
  Animation<double> _scaleAnimation;

  File _image;
  int contador = 0;
  TextEditingController txtController = new TextEditingController();
  bool txtEnable = true;
  String comentario = "";
  String degetos = "";
  Position _position;
  String nome, email, imagem;
  String endereco = "Buscando endereço...";
  bool carregando = false;
  bool enviando = false;
  bool pegouLocalizacao = false;

  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);

  Icon flag = Icon(FontAwesomeIcons.circle);

  double lat = 0.0;
  double lon = 0.0;

  adicionarDegetos(String deg) {
    setState(() {
      degetos += deg + "   ";

      //degetos = degetos.substring(0, degetos.length - 1);
    });
  }

  removerDegeto(String deg) {
    setState(() {
      degetos = degetos.replaceAll(deg + "   ", "");

      //degetos = degetos.substring(0, degetos.length - 1);
    });
  }

  buscarUsuario() async {
    final pref = await SharedPreferences.getInstance();

    List<String> usuario = pref.getStringList("usuario");

    setState(() {
      nome = usuario[1];
      imagem = usuario[2];
      email = usuario[3];
    });
  }

  getPosition() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 10);

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());

      setState(() {
        lat = position.latitude;
        lon = position.longitude;
        pegouLocalizacao = true;
      });

      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      String pais, estado, cidade;
      pais = placemark[0].country;
      estado = placemark[0].administrativeArea;
      cidade = placemark[0].subAdministrativeArea;

      setState(() {
        endereco = pais + " - " + estado + ", " + cidade;
        print(pais + " - " + estado + ", " + cidade);
      });
      print(placemark[0].subAdministrativeArea);
      print(placemark[0].subLocality);
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 400.0, maxHeight: 200.0);
    setState(() {
      _image = image;

      /*
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => ResiduosPage(
                    image: _image,
                  )),
          (Route route) => route == null);
          */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Publicar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //postar();
            },
            icon: Icon(
              FontAwesomeIcons.paperPlane,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                      Colors.blue,
                      Colors.blue,
                    ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        tileMode: TileMode.clamp)),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: txtController,
                        onChanged: ((str) {
                          setState(() {
                            if (str.length > 100) {
                              txtController.text = str.substring(0, 100);
                            } else {
                              contador = str.length;
                              comentario = str;
                            }
                          });
                        }),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        autofocus: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Comentário",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "${contador}/100",
                              style: TextStyle(color: Colors.white70),
                              textAlign: TextAlign.end,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: pegouLocalizacao ? Colors.green : Colors.red,
                  ),
                title: Text("Localização"),
                subtitle: Text(endereco),
              ),
              ListTile(
                onTap: () {
                  //adicionarDegetos();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => TiposDegetosPage(
                              adicionarDegetos, removerDegeto)));
                },
                leading: Icon(FontAwesomeIcons.tags),
                title: Text("Tipos de degetos"),
                subtitle: Text(degetos),
              ),
              _image == null
                  ? Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Icon(
                        FontAwesomeIcons.image,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    )
                  : Image.file(
                      _image,
                      width: 200.0,
                      height: 200.0,
                    )
            ],
          ),

          /*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[400],
                  ),
                  child: 
                  _image == null ?
                  Icon(
                    FontAwesomeIcons.camera,
                    color: Colors.grey[800],
                    size: 60.0,
                  )
                  :
                  Image.file(_image)
                ),
              )
            ),

            */

          !enviando
              ? ScaleTransition(
                  scale: _scaleAnimation,
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    onTapDown: (e) {
                      print("tapped down");
                      animationController.forward();
                    },
                    onTapUp: (e) {
                      print("tapped up");
                      animationController.reset();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                          width: 60.0,
                          height: 60.0,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Container(
                              width: 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 6.0),
                          )),
                    ),
                  ),
                )
              : SpinKitThreeBounce(
                  color: Colors.blue,
                  size: 30.0,
                  duration: Duration(milliseconds: 900),
                  /*
              itemBuilder: (_, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
              */
                )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarUsuario();
    getPosition();

    animationController = AnimationController(

        duration: Duration(milliseconds: 100), vsync: this);
    _scaleAnimation = Tween(begin: 0.9, end: 1.0).animate(animationController);
  }
}
