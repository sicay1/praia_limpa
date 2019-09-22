import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/FormCardCadastro.dart';
import '../Widgets/SocialIcons.dart';
import '../CustomIcons.dart';
//import '../principal/index.dart';
//import '../main/index.dart';
import '../intro/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../login/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => new _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSelected = false;
  File _image;
  String nome = "", email = "", senha = "";


  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  cadastrarSql() async {
    String base64Image;
    if (nome == "" || email == "" || senha == "") {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Preencha todos os campos e escolha uma foto',
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      setState(() {
        //carregando = true;
      });
      if(_image == null){
        base64Image = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+P+/HgAFhAJ/wlseKgAAAABJRU5ErkJggg==";
      }else{
        List<int> imageBytes = _image.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
      }

      var res = await http.post(
          Uri.parse("${Usuario.urlBase}adicionarUsuario.php"),
          body: {
            "nome": nome,
            "email": email,
            "senha": senha,
            "foto": base64Image,
          },
          //Uri.parse("${Usuario.urlBase}adicionarUsuario.php?nome=Daniel&email=teste@teste.com&senha=12345&foto=foto"),
          headers: {
            "Accept": "application/json"
          });

      var obj = json.decode(res.body);
      print(obj);
      try {
        if (obj.length > 0) {
          final snackBar = SnackBar(
            backgroundColor: Colors.teal,
            content: Text('Obrigado pelo seu cadastro',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: "NunitoBold")),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);

          await Future.delayed(new Duration(seconds: 2));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route route) => route == null);
        } else {
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('Algo deu errado :/',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: "NunitoBold")),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      } catch (e) {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'Algo deu errado. Parece que alguém já está usando esse email.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: "NunitoBold")),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 200.0, maxHeight: 200.0);
    setState(() {
      _image = image;
    });
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
          height: 1.5,
          color: CoresDoProjeto.principal,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              horizontalLine(),
                              GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: Center(
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            color: CoresDoProjeto.principal),
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(FontAwesomeIcons.plus,
                                        color: CoresDoProjeto.principal),
                                  ),
                                ),
                              ),
                              horizontalLine(),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 50.0,
                            child: TextField(
                              textCapitalization: TextCapitalization.words,
                              onChanged: ((str) {
                                setState(() {
                                  nome = str;
                                });
                              }),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: CoresDoProjeto.principal,
                                      width: 1.2,
                                    ),
                                  ),
                                  hintText: "Nome",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17.0)),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            height: 50.0,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: ((str) {
                                setState(() {
                                  email = str;
                                });
                              }),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: CoresDoProjeto.principal,
                                      width: 1.2,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17.0)),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            height: 50.0,
                            child: TextField(
                              onChanged: ((str) {
                                setState(() {
                                  senha = str;
                                });
                              }),
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: CoresDoProjeto.principal,
                                      width: 1.2,
                                    ),
                                  ),
                                  hintText: "Senha",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17.0)),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.0),
                                child: GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                      height: 74.0,
                                      width: 74.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey[400],
                                      ),
                                      child: _image == null
                                          ? Icon(
                                              FontAwesomeIcons.image,
                                              color: Colors.grey[800],
                                              size: 30.0,
                                            )
                                          : Image.file(_image)),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: 250.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                //Color(0xFF17ead9),
                                //Color(0xFF6078ea)
                                CoresDoProjeto.principal,
                                CoresDoProjeto.principal,
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
                                cadastrarSql();
                              },
                              child: Center(
                                child: Text("Cadastrar",
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
                  InkWell(
                    child: Container(
                      width: 250.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          //Color(0xFF17ead9),
                          //Color(0xFF6078ea)
                          Colors.transparent,
                          Colors.transparent
                        ]),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text("Voltar",
                                style: TextStyle(
                                  color: Colors.black,
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
            ),
          )
        ],
      ),
    );
  }
}
