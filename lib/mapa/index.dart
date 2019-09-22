import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_praia_limpa/common/registro.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/drawer.dart';
import '../common/confirm.dart';
import '../post/postar.dart';
import 'package:geolocator/geolocator.dart';
import '../feed/index.dart';
import '../common/usuario.dart';
import '../post/inst.dart';

import 'package:file_picker/file_picker.dart';
import '../common/colors.dart';

Confirm c = new Confirm();

class MapaPage extends StatefulWidget {
  double latitudeMapa;
  double longitudeMapa;

  MapaPage({this.latitudeMapa, this.longitudeMapa});
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> 
with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> _scaleAnimation;
  File _image;
  double lat = 0.0;
  double lon = 0.0;
  bool pegouLocalizacao = false;
  
  BitmapDescriptor iconeVermelho;
  BitmapDescriptor iconeAzul;
  BitmapDescriptor iconeAmarelo;
  BitmapDescriptor iconeVerde;
  BitmapDescriptor iconeCinza;
  BitmapDescriptor iconeRoxo;
  BitmapDescriptor iconeLaranja;
  BitmapDescriptor iconeMarrom;

    String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;

  GoogleMapController myController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Set<Marker> markers = new Set();

  BitmapDescriptor selecionarIcone(List<int> tipos){
    BitmapDescriptor icone;
    
    if (tipos[0] > 0 && tipos[0] <= 13) {
      return iconeVermelho;
    } else if (tipos[0] >= 14 && tipos[0] <= 36) {
      return iconeVermelho;
    } else if (tipos[0] >= 37 && tipos[0] <= 40) {
      return iconeMarrom;
    } else if (tipos[0] >= 41 && tipos[0] <= 44) {
      return iconeVerde;
    } else if (tipos[0] >= 45 && tipos[0] <= 49) {
      return iconeAmarelo;
    } else if (tipos[0] >= 50 && tipos[0] <= 55) {
      return iconeAzul;
    } else if (tipos[0] >= 56 && tipos[0] <= 58) {
      return iconeMarrom;
    } else if (tipos[0] == 59) {
      return iconeRoxo;
    }
    return icone;
  }

  buscarPostsSql() {
    for (var registro in Registro.listaRegistros) {

      BitmapDescriptor icone = iconeAmarelo;

      setState(() {
         markers.add(new Marker(
          onTap: () async {
            double distanceInMeters = await Geolocator().distanceBetween(registro.latitude, registro.longitude, Usuario.lat, Usuario.lon);
            print("DISTANCIA: ${distanceInMeters}");

            c.showConfirm(context, registro, distanceInMeters < 15.0, registro.imagemAutor);
            
          },
          markerId: MarkerId(registro.id),
          position: LatLng(registro.latitude, registro.longitude),
          infoWindow: InfoWindow(title: registro.comentario),
          icon: registro.icone));
      });
      
    }
  }


    getPosition() async {
      
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 10);

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async {
          
          print("entrou no get position");
          setState(() {
            lat = position.latitude;
            lon = position.longitude;

            Usuario.lat = position.latitude;
            Usuario.lon = position.longitude;
            pegouLocalizacao = false;
          });

          List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
          
          Usuario.estado = placemark[0].administrativeArea;
          Usuario.cidade = placemark[0].subAdministrativeArea;

          setState(() {
            //localizacao = "${Usuario.cidade},${Usuario.estado}";  
          });
    });
  }

  calcularDistancia() async {
    double distanceInMeters = await Geolocator().distanceBetween(-5.9791, -35.120686, -5.9791, -35.120690);
    print("DISTANCIA: ${distanceInMeters}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/amarelo.png')
        .then((onValue) {
      iconeAmarelo = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/azul.png')
        .then((onValue) {
      iconeAzul = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/vermelho.png')
        .then((onValue) {
      iconeVermelho = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/verde.png')
        .then((onValue) {
      iconeVerde = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/cinza.png')
        .then((onValue) {
      iconeCinza = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/roxo.png')
        .then((onValue) {
      iconeRoxo = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/marrom.png')
        .then((onValue) {
      iconeMarrom = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48.0, 48.0)), 'assets/pins/laranja.png')
        .then((onValue) {
      iconeLaranja = onValue;
    });

    getPosition();
    buscarPostsSql();
    
    //calcularDistancia();
    animationController = AnimationController(

        duration: Duration(milliseconds: 100), vsync: this);
    _scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      /*
      appBar: AppBar(
        backgroundColor: CoresDoProjeto.principal,
        leading: new IconButton(
            icon: new Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        title: Text("Mapa", style: TextStyle(color: Colors.white, fontFamily: "Poppins-Medium",)),
      ),
      */
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      drawer: CustomDrawer(),
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[

          
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: GoogleMap(
                  myLocationEnabled: true,
                  //compassEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitudeMapa == null ? Usuario.lat : widget.latitudeMapa, widget.longitudeMapa == null ? Usuario.lon : widget.longitudeMapa), 
                      zoom: widget.latitudeMapa == null ? 12.0 : 15.0,),
                  onMapCreated: (controller) {
                    setState(() {
                      myController = controller;
                      myController.setMapStyle('[{"featureType": "water","stylers": [{ "color": "#b3b3b3" }]}, {"featureType": "landscape","stylers": [{ "color": "#e6e6e6" }]}, {"featureType": "road","stylers": [{ "color": "#f2f2f2" }]}, {"featureType": "poi","stylers": [{ "visibility": "off" }]}]');
                    });
                  },
                  
                  markers: markers,
                ),
              )
            ],
          ),

          Positioned(
            top: 50.0,
            right: 20.0,
            child: InkWell(
                        child: Container(
                          width: 50.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                //Color(0xFF17ead9),
                                //Color(0xFF6078ea)
                                Colors.white,
                                Colors.white,
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                              child: Center(
                                child: Icon(FontAwesomeIcons.bars, color: CoresDoProjeto.principal,),
                              ),
                            ),
                          ),
                        ),
                      ),
          )
          
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ScaleTransition(
                  scale: _scaleAnimation,
                  child: GestureDetector(
                    
                    onTapDown: (e) {
                      print("tapped down");
                      animationController.forward();
                    },
                    onTapUp: (e) {
                      print("tapped up");
                      animationController.reverse();
                        Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => InstPage()),
                        (Route route) => route == null);
                      
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                          width: 80.0,
                          height: 80.0,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Container(
                              
                              decoration: BoxDecoration(
                                  //color: Colors.grey, shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/camera.png",)
                                  )
                                ),
                            ),
                          )),
                    ),
                  ),
                ),
          //onPressed: () {}),
    );
  }
}
