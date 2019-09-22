import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/splash/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalizacaoErro extends StatefulWidget {
  @override
  _LocalizacaoErroState createState() => _LocalizacaoErroState();
}

class _LocalizacaoErroState extends State<LocalizacaoErro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /*
          AnimatedIcon(
            icon: AnimatedIcons.,
            progress: controller,
            semanticLabel: 'Show menu',
          ),
          */
          Icon(FontAwesomeIcons.mapMarkedAlt, color: Colors.white, size: 80.0,),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text("Este aplicativo depende da localização para funcionar", textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text("Voltar", style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (BuildContext context) => SplashPage()),
                    (Route route) => route == null);
                },
              ),
              FlatButton(
                child: Text("Abrir configurações", style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
                onPressed: ()  {
                  //await PermissionHandler().requestPermissions([PermissionGroup.location]);
                  AppSettings.openLocationSettings();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //PermissionHandler().requestPermissions([PermissionGroup.location]);
  }
}

//