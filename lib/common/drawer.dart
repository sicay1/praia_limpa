import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/beneficios/index.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:flutter_praia_limpa/login/index.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../perfil/perfil.dart';
import '../empresas/index.dart';
import '../doe/index.dart';
import '../post/meus_posts.dart';
import '../sobre/index.dart';
import '../ajuda/index.dart';
import 'colors.dart';

class CustomDrawer extends StatefulWidget {
  @override
  createState() => new CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  var _name = '';
  var _email = '';
  var _imagem = '';
  var id = '';

  formatarNome(String nome){
    if(nome.length < 13){
      return nome;
    }else{
      return nome.substring(0, 13) + "...";
    }
  }

  buscarUsuario() async {

    final pref = await SharedPreferences.getInstance();

    List<String> usuario = pref.getStringList("usuario");

    setState(() {
      id = usuario[0];
      _name = usuario[1];
      _imagem = usuario[2];
      _email = usuario[3];
    });
  }

  MemoryImage base64ToImageProvider(String img) {
    return MemoryImage(base64Decode(img));
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: new ListView(
        // Important: Remove any padding from the ListView.
        padding: new EdgeInsets.all(0.0),
        children: <Widget>[
          new InkWell(
            child: new Container(

              padding: const EdgeInsets.only(bottom: 0.0, left: 10.0),
              margin: const EdgeInsets.only(top: 50.0, bottom: 20.0, left: 0.0),
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 10.0),
                    child: CircleAvatar(
                      backgroundImage: base64ToImageProvider(_imagem),
                    ),
                  ),
                  
                  
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          formatarNome(_name),
                          style: new TextStyle(
                              fontSize: 22.0, fontFamily: 'NunitoRegular', color: CoresDoProjeto.principal),
                        ),
                        new Text(
                          _email,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: const Color.fromRGBO(0, 0, 0, 0.8),
                              fontFamily: 'Avenir'),
                        )
                      ],
//
                    ),
                  ),

                  IconButton(
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PerfilPage(Usuario.id, _name, _email, _imagem)));
                    },
                    icon: Icon(FontAwesomeIcons.pencilAlt), iconSize: 20.0, color: CoresDoProjeto.principal,)
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),

          /*
          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    //left: BorderSide(
                      //  color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2),
                    bottom: BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.map,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Mapa',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()),
                                (Route route) => route == null);
              
              //Navigator.pushNamed(context, "/home");
            },
          ),

          */

          /*

          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.userAlt,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Perfil',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PerfilPage(id)));
              
              //Navigator.pushNamed(context, "/home");
            },
          ),

          */

          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Meus Registros',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MeusPostsPage()));
              
              //Navigator.pushNamed(context, "/home");
            },
          ),

          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.gift,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Usar Beneficios',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BeneficiosPage()));
              
              //Navigator.pushNamed(context, "/home");
            },
          ),

          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.users,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Parceiros',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EmpresasPage()));
              
              //Navigator.pushNamed(context, "/home");
            },
          ),


          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.dollarSign,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Doe',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DoePage()));
              
              //Navigator.pushNamed(context, "/home");
            },
          ),

          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.question,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Sobre',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SobrePage()));
              
              //Navigator.pushNamed(context, "/home");
            },
          ),

          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.handsHelping,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Ajuda',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () {
              
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AjudaPage()));
              
              //Navigator.pushNamed(context, "/home");
            },
          ),

          new ListTile(
            title: new Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(70, 170, 160, 1.0), width: 1.2)),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: new Icon(
                            FontAwesomeIcons.backspace,
                            size: 25.0,
                            color: CoresDoProjeto.principal,
                          )),
                      new Text(
                        'Sair',
                        style:
                            new TextStyle(fontSize: 18.0, fontFamily: 'Montserrat-Medium'),
                      ),
                    ],
                  ),
                  new Text(
                    '',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: new Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                ],
              ),
            ),
            onTap: () async {

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setStringList("usuario", null);
              
              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginPage()),
                                (Route route) => route == null);
            },
          ),

          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  _iniciarFacebook();
                },
                child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.facebook, color: CoresDoProjeto.principal, size: 30.0),
                  SizedBox(width: 10.0,),
                  Text("facebook", style: TextStyle(fontSize: 20.0, color: Colors.teal[900]))
                ],
              ),
              ),

              SizedBox(height: 20.0,),
              
              

              GestureDetector(
                onTap: (){
                  _iniciarInstagram();
                },
                child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.instagram, color: Colors.pink, size: 30.0),
                  SizedBox(width: 10.0,),
                  Text("Instagram", style: TextStyle(fontSize: 20.0, color: Colors.teal[900]))
                ],
              ),
              ),
            ],
          ),
          ),

          SizedBox(height: 50.0,)
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarUsuario();
  }
  
  //https://www.instagram.com/mar_limpo/

  _iniciarFacebook() async {
    const url = "https://www.facebook.com/ong.oceanica/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch facebook';
    }
  }

  _iniciarInstagram() async {
    const url = "https://www.instagram.com/ong.oceanica/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch instagram';
    }
  }
}
