import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:flutter_praia_limpa/feed/confirmacao.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main/index.dart';
import 'colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SanarPage extends StatefulWidget {
  String id;
  SanarPage(this.id);

  @override
  _SanarPageState createState() => _SanarPageState();
}

class _SanarPageState extends State<SanarPage> {

  bool carregando = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);


  mostrarSnackBar(String msg) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg, style: estiloMensagem),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
  }

    sanarSql(String registro) async {
      var res = await http.post(
        Uri.parse("${Usuario.urlBase}sanar.php"),
        body: {
          "registro": registro,
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);

      if(obj == true){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => ConfirmacaoPage(regarregar: true,)),
            (Route route) => route == null);
      }else{
        mostrarSnackBar('Erro na tentativa de marcar o registro como sanado!');
      }
     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: CoresDoProjeto.principal,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
        ),
      ),
      backgroundColor: CoresDoProjeto.principal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("Tem certeza que os resíduos foram removidos?", textAlign: TextAlign.center, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Poppins-Medium"),),
          ),
          SizedBox(
            height: 40.0,
          ),
          carregando ? 
          SpinKitThreeBounce(
            color: Colors.white,
            size: 20.0,
            duration: Duration(milliseconds: 900),
          )
          :
          InkWell(
                        child: Container(
                          width: 150.0,
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
                              onTap: () => sanarSql(widget.id),
                              child: Center(
                                child: Text("CONFIRMAR",
                                    style: TextStyle(
                                        color: CoresDoProjeto.principal,
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
    );
  }
}