import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Widgets/FormCard.dart';
import '../Widgets/SocialIcons.dart';
import '../CustomIcons.dart';
//import '../principal/index.dart';
//import '../main/index.dart';
import '../intro/index.dart';
import '../cadastro/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/loading.dart';
import '../common/usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'fb_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSelected = false;
  bool obscure = true;
  bool carregando = false;
  String email = "", pass = "";

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  salvarUsuario(String docId, String nome, String imagem, String email) async {
    final pref = await SharedPreferences.getInstance();
    List<String> info_usuario = new List();
    Usuario.id = docId;
    info_usuario.add(docId);
    info_usuario.add(nome);
    info_usuario.add(imagem);
    info_usuario.add(email);
    pref.setStringList('usuario', info_usuario);

    setState(() {
      carregando = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => IntroPage()),
        (Route route) => route == null);
  }

  loginSql() async {
    if (email == "" || pass == "") {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Preencha os dois campos',
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      setState(() {
        carregando = true;
      });

      var res = await http.get(
          Uri.parse("${Usuario.urlBase}login.php?email=$email&senha=$pass"),
          headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);

      if (obj.length > 0) {
        salvarUsuario("${obj['id']}", "${obj['nome']}", "${obj['foto']}",
            "${obj['email']}");
      } else {
        setState(() {
          carregando = false;
        });
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Usuário não encontrado!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: "NunitoBold")),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }

      setState(() {});
    }
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/logo.png",
                        width: 250.0,
                        height: 80.0,
                        //width: ScreenUtil.getInstance().setWidth(300),
                        //height: ScreenUtil.getInstance().setHeight(100),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    //height: ScreenUtil.getInstance().setHeight(500),
                    /*
      decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
          */
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            child: TextField(
                              //textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: ((txt) {
                                setState(() {
                                  email = txt;
                                });
                              }),
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CoresDoProjeto.principal,
                                      width: 1.2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CoresDoProjeto.principal,
                                      width: 1.2),
                                ),
                                hintText: 'E-mail',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                child: TextField(
                                  onChanged: ((txt) {
                                    setState(() {
                                      pass = txt;
                                    });
                                  }),
                                  onSubmitted: (e) {
                                    loginSql();
                                  },
                                  obscureText: obscure,
                                  decoration: new InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CoresDoProjeto.principal,
                                          width: 1.2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CoresDoProjeto.principal,
                                          width: 1.2),
                                    ),
                                    hintText: 'Senha',
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 3.0,
                                right: 4.0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  color: Colors.grey,
                                  icon: Icon(obscure
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash),
                                  iconSize: 20.0,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(35),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Esqueceu a senha?",
                                style: TextStyle(
                                    color: CoresDoProjeto.principal,
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(28)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      carregando
                          ? SpinKitThreeBounce(
                              color: CoresDoProjeto.principal,
                              size: 30.0,
                              duration: Duration(milliseconds: 900),
                            )
                          : InkWell(
                              child: Container(
                                width: 250.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      //Color(0xFF17ead9),
                                      //Color(0xFF6078ea)
                                      CoresDoProjeto.principal,
                                      CoresDoProjeto.principalClara,
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color(0xFF6078ea).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ]),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      loginSql();
                                    },
                                    child: Center(
                                      child: Text("Entrar",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Medium",
                                            fontSize: 16,
                                            //letterSpacing: 1.0
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Text("Não é cadastrado?",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: "Poppins-Medium",
                        fontSize: 16,
                        //letterSpacing: 1.0
                      )),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  InkWell(
                    child: Container(
                      width: 250.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            //Color(0xFF17ead9),
                            //Color(0xFF6078ea)
                            CoresDoProjeto.principal,
                            CoresDoProjeto.principalClara,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CadastroPage()));
                          },
                          child: Center(
                            child: Text("Cadastre-se",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: 16,
                                  //letterSpacing: 1.0
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Facebook",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          CoresDoProjeto.principalClara,
                          CoresDoProjeto.principalClara,
                          CoresDoProjeto.principalClara,
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FacebookLoginPage()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
