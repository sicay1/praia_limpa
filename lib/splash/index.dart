import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_praia_limpa/common/degetos.dart';
import 'package:flutter_praia_limpa/common/registro.dart';
import 'package:flutter_praia_limpa/feed/confirmacao.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/index.dart';
import '../main/index.dart';
import '../common/usuario.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import 'localizacao.dart';
//import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> _scaleAnimation;
  double lat = 0.0;
  double lon = 0.0;
  bool enviado = false;
  bool pegouLocalizacao = false;

  estaLogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList("usuario") == null ||
        prefs.getStringList("usuario").isEmpty) {
      //await Future.delayed(new Duration(seconds: 1));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route route) => route == null);
    } else {
      Usuario.id = prefs.getStringList("usuario")[0];
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MainPage()),
          (Route route) => route == null);
      /*
      List<String> usuario = prefs.getStringList("usuario");
      String id = usuario[0];

      if(prefs.getBool("enviado1") != null && prefs.getBool("enviado1") == false){
        print("post 1");
        postar(id,
              prefs.getString("comentario1"), 
              prefs.getString("autor1"), 
              prefs.getString("imagem1"),
              prefs.getStringList("tipos1"), 
              prefs.getDouble("latitude1"), 
              prefs.getDouble("longitude1"));
        prefs.setBool("enviado1", true);
      }

      if(prefs.getBool("enviado2") != null && prefs.getBool("enviado2") == false){
        print("post 2");
        postar(id,
              prefs.getString("comentario2"), 
              prefs.getString("autor2"), 
              prefs.getString("imagem2"),
              prefs.getStringList("tipos2"), 
              prefs.getDouble("latitude2"), 
              prefs.getDouble("longitude2"));
        prefs.setBool("enviado2", true);
      }

      if(prefs.getBool("enviado3") != null && prefs.getBool("enviado3") == false){

        print("post 3");
        postar(id,
              prefs.getString("comentario3"), 
              prefs.getString("autor3"), 
              prefs.getString("imagem3"),
              prefs.getStringList("tipos3"), 
              prefs.getDouble("latitude3"), 
              prefs.getDouble("longitude3"));
        prefs.setBool("enviado3", true);
      }


      Usuario.id = prefs.getStringList("usuario")[0];
      Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()),
                                (Route route) => route == null);
                                */
    }
  }

/*
  _handleLocation() async {
    await PermissionHandler().requestPermissions(
        [
          PermissionGroup.camera, 
          PermissionGroup.microphone
        ]);
  }
  */

  erroLocalizacao() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => LocalizacaoErro()));
  }

  getPosition() async {

    //PermissionStatus permission = await 
    
    PermissionHandler().checkPermissionStatus(PermissionGroup.location).then((permission){

      if(permission == PermissionStatus.granted){
                  var geolocator = Geolocator();
        var locationOptions = LocationOptions(
            accuracy: LocationAccuracy.best, distanceFilter: 10);

        StreamSubscription<Position> positionStream = geolocator
            .getPositionStream(locationOptions)
            .listen((Position position) async {
          setState(() {
            lat = position.latitude;
            lon = position.longitude;

            Usuario.lat = position.latitude;
            Usuario.lon = position.longitude;
            pegouLocalizacao = false;

            estaLogado();
          });

          List<Placemark> placemark = await Geolocator()
              .placemarkFromCoordinates(position.latitude, position.longitude);

          Usuario.estado = placemark[0].administrativeArea;
          Usuario.cidade = placemark[0].subAdministrativeArea;
        });
      }else{
        erroLocalizacao();
      }
    });
    

    //Map<PermissionGroup, PermissionStatus> permissions = await 
    /*
    PermissionHandler().requestPermissions([PermissionGroup.location]).then((permission){
      var geoLocator = Geolocator();
    geoLocator.checkGeolocationPermissionStatus().then((status) {
      if (status == GeolocationStatus.denied) {
        erroLocalizacao();
      }
      // Take user to permission settings
      else if (status == GeolocationStatus.disabled) {
        erroLocalizacao();
      }
      // Take user to location page
      else if (status == GeolocationStatus.restricted) {
        erroLocalizacao();
      }
      // Restricted
      else if (status == GeolocationStatus.unknown) {
        erroLocalizacao();
      }
      // Unknown
      else if (status == GeolocationStatus.granted) {
        
      }
    });
    });
    */
  }

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          child: FadeTransition(
        opacity: _scaleAnimation,
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login.jpg"), fit: BoxFit.cover)),
        ),
      )),
    );
  }

  BitmapDescriptor selecionarIcone(int id) {
    switch (id) {
      case 1:
        return BitmapDescriptor.fromAsset('assets/pins/vermelho.png');
        break;
      case 2:
        return BitmapDescriptor.fromAsset('assets/pins/vermelho.png');
        break;
      case 3:
        return BitmapDescriptor.fromAsset('assets/pins/marrom.png');
        break;
      case 4:
        return BitmapDescriptor.fromAsset('assets/pins/verde.png');
        break;
      case 5:
        return BitmapDescriptor.fromAsset('assets/pins/amarelo.png');
        break;
      case 6:
        return BitmapDescriptor.fromAsset('assets/pins/amarelo.png');
        break;
      case 7:
        return BitmapDescriptor.fromAsset('assets/pins/azul.png');
        break;
      case 8:
        return BitmapDescriptor.fromAsset('assets/pins/marrom.png');
        break;

      default:
        return BitmapDescriptor.fromAsset('assets/pins/marrom.png');
    }
  }

  buscarRegistrosSql() async {
    List<Registro> tempListaRegistros = new List();
    var res = await http.get(Uri.parse("${Usuario.urlBase}registros.php"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);

    for (var item in objetos['registros']) {

      int categoria = 0;
      try {
        categoria = int.parse(item['residuos'][0]['categoria']);
      } catch (e) {
        categoria = 1;
      }
      //print(item['registro']['registro_id']);
      tempListaRegistros.add(new Registro(

          id: item['registro']['registro_id'],
          idAutor: item['registro']['usuario_id'],
          nomeAutor: item['registro']['nome'],
          comentario: item['registro']['comentario'],
          dataStr: item['registro']['data_registro'],
          imagemPost: item['registro']['imagem'],
          imagemAutor: item['registro']['foto'],
          latitude: double.parse(item['registro']['latitude']),
          longitude: double.parse(item['registro']['longitude']),
          verificando: false,
          status: int.parse(item['registro']['sts']),
          icone: selecionarIcone(categoria)));
      
    }

    setState(() {
      Registro.listaRegistros = tempListaRegistros;
      //print("${tempListaRegistros.length}");
      this.getPosition();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    _scaleAnimation = Tween(begin: 0.1, end: 1.0).animate(animationController);

    animationController.forward();
    
    //this.buscarRegistrosSql();

    
    PermissionHandler().requestPermissions([PermissionGroup.location]).then((e){
        this.buscarRegistrosSql();
    });
    
  }
}
