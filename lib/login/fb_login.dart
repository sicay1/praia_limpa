import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:flutter_praia_limpa/intro/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart';

class FacebookLoginPage extends StatefulWidget {
  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final facebookLogin = FacebookLogin();
  bool carregando = true;
  var profile;
  String _nome, _email;
  String urlImagem;

  logar() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    print("status ${result.status}");

    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture.height(200),email&access_token=${token}');

    setState(() {
      profile = json.decode(graphResponse.body);
      carregando = false;
      _nome = profile['name'];
      _email = profile['email'];
      urlImagem = profile["picture"]["data"]["url"];
    });
    
    print(profile);
  }

  salvarUsuario(String docId, String nome, String imagem, String email) async {
    final pref = await SharedPreferences.getInstance();
    List<String> info_usuario = new List();
    Usuario.id = docId;
    print("IDDDDDDDDD OD DD UUSUUUAARRIROOIROIROIORIORIORI!!!!!!!");
    print(Usuario.id);

    info_usuario.add(docId);
    info_usuario.add(nome);
    info_usuario.add(imagem);
    info_usuario.add(email);
    pref.setStringList('usuario', info_usuario);
    
    setState(() {
      carregando = false;
    });
    
    Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    IntroPage()),
                                            (Route route) => route == null);
  }



    cadastrarSql() async {
     
       setState(() {
        //carregando = true;
      });

      var _image = await DefaultCacheManager().getSingleFile(urlImagem);
      List<int> imageBytes = _image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      var res = await http.post(
        Uri.parse("${Usuario.urlBase}adicionarUsuario.php"),
        body: {
          "nome": _nome,
          "email": _email,
          "senha": 'fb1234',
          "foto": base64Image,
          },
        //Uri.parse("${Usuario.urlBase}adicionarUsuario.php?nome=Daniel&email=teste@teste.com&senha=12345&foto=foto"),
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);
      
      try{
        if(obj.length > 0){
        final snackBar = SnackBar(
          backgroundColor: Colors.teal,
          content: Text('Obrigado pelo seu cadastro', style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);

        await Future.delayed(new Duration(seconds: 2));
        salvarUsuario(obj['lojas'][0]['id'].toString(), _nome, base64Image, _email);
      }else{
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Algo deu errado :/', style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
      }catch(e){
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Algo deu errado. Parece que alguém já está usando esse email.', style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "NunitoBold")),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
      
    
  }

  Widget buildUI() {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
                width: 130.0,
                height: 130.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.teal, width: 3.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(profile["picture"]["data"]["url"])))),
            SizedBox(
              height: 10.0,
            ),
            Text(
              profile["first_name"] == null ? "" : profile["name"],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                  fontFamily: "Sans"),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    child: Center(
                        child: Icon(
                      FontAwesomeIcons.times,
                      color: Colors.red,
                    )),
                    onPressed: () {
                      facebookLogin.logOut();
                      Navigator.of(context).pop();
                    },
                    color: Colors.transparent),
                FlatButton(
                    child: Center(
                        child: Icon(
                      FontAwesomeIcons.check,
                      color: Colors.green,
                    )),
                    onPressed: () {
                      //verificarSeUsuarioExiste();
                      cadastrarSql();
                    },
                    color: Colors.transparent),
              ],
            )
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /*
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Logo.logoG,
          ),
          */
          carregando
              ? Center(
                  child: SizedBox(
                  child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(Colors.teal),
                      strokeWidth: 5.0),
                  height: 20.0,
                  width: 20.0,
                ))
              :
              //Container()
              buildUI(),
          Container()
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    logar();
  }
}
