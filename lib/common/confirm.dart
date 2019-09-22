import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/degetos.dart';
import 'package:flutter_praia_limpa/common/registro.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:flutter_praia_limpa/detalhes/index.dart';
import 'package:flutter_praia_limpa/feed/motivoNegacao.dart';
import '../main/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'sanar.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Confirm {


  adicionarResiduo(String residuo, String registro, String qtd, BuildContext context) async {
      var res = await http.post(
        Uri.parse("${Usuario.urlBase}adicionarResiduo.php"),
        body: {
          "residuo": residuo,
          "registro": registro,
          "qtd": qtd,
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);

      if(obj == true){
        Navigator.of(context).pop(int.parse(qtd));
      }else{
        print("erro");
      }
  }


  removerResiduo(String residuo, String registro, BuildContext context) async {
      var res = await http.post(
        Uri.parse("${Usuario.urlBase}removerResiduo.php"),
        body: {
          "residuo": residuo,
          "registro": registro
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);

      if(obj == true){
        Navigator.of(context).pop(true);
      }else{
        print("erro");
      }
  }

  Image base64ToImage(String img) {
    return Image.memory(base64Decode(img));
  }

  MemoryImage base64ToImageProvider(String img) {
    return MemoryImage(base64Decode(img));
  }


  String formatarHoraStr(String time, int status) {
    String res = time.substring(0,10);
    var str = res.split("-");
    String msg = "";
    if(status == 1){
      msg = " - Não validado";
    }
    return str[2] + "/" + str[1] + "/" + str[0] + msg;
  }









  Future<bool> showConfirm(context, Registro document, bool sanar, String imagemAutor) {

    return showDialog(
      barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          double w = MediaQuery.of(context).size.width;
          return Material(
            borderOnForeground: true,
            type: MaterialType.transparency,
            child: Center(
                // Aligns the container to center
                child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pop();
                  },
                  child: Container(
                    // A simplified version of dialog.
                    width: w - 60.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: CoresDoProjeto.principal, width: 2.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 50.0, right: 10.0),
                              height: 30.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  color: Colors.transparent),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    document.nomeAutor,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontFamily: "NunitoLight",
                                        fontSize: 20.0),
                                  ),

                                  Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          if(document.status == 1){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext context) => MotivoNegacaoPage(document.id,"",0,0,"")));
                                          }else{
                                            Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) => DetalhesPage(document, sanar, imagemAutor)));
                                          }
                                          
                                        },
                                        child: Container(
                                        height: 170.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: CoresDoProjeto.principal,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: CoresDoProjeto.principal,
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage("${Usuario.urlBase}/uploads/${document.imagemPost}")),
                                        ),
                                      ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Text(
                                  document.comentario,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 0.0),
                                child: Text(
                                  formatarHoraStr(document.dataStr, document.status),
                                  style: TextStyle(color: Colors.teal[800], fontSize: 17.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.0),
                      ],
                    )),
                ),
                Positioned(
                  top: -20.0,
                  left: -20.0,
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.purple, width: 2.0),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: base64ToImageProvider(imagemAutor)),
                    ),
                  ),
                ),

                Positioned(
                  top: -20.0,
                  right: -20.0,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.purple, width: 2.0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(FontAwesomeIcons.times),
                  ),
                  )
                )
              ],
            )),
          );
        });
  }

  Future<bool> confirmarVoto(context, bool ac, String docId, String idPost) {
    String msg = "";
    if (ac) {
      msg = "Tem certeza que esta postagem é valida?";
    } else {
      msg = "Tem certeza que esta postagem não é válida?";
    }

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  color: Colors.blue),
                              child: Center(
                                child: Text(
                                  "Confirme o seu voto",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              )),
                        ],
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  msg,
                                  style: TextStyle(fontSize: 15.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'NÃO',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.red),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.transparent),
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'SIM',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.teal),
                                ),
                              ),
                              onPressed: () {
                                //votarAFavor(docId, idPost);
                                Navigator.pop(context);
                              },
                              color: Colors.transparent)
                        ],
                      ),
                    ],
                  )));
        });
  }
  

  Future<int> quantificarItem(context, int id, String tipo, String registro) {
    int qtd = 0;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  height: 400.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  color: CoresDoProjeto.principal),
                              child: Center(
                                child: Text(
                                  tipo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              )),
                        ],
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: <Widget>[
                                  RadioButtonGroup(
                                      labelStyle: TextStyle(fontSize: 17.0, fontFamily: "NunitoBold"),
                                      labels: <String>[
                                        "1 - 20",
                                        "21 - 50",
                                        "51 - 100",
                                        "Mais de 100",
                                      ],
                                      onSelected: (String selected) {
                                        if(selected == "1 - 20"){
                                          qtd = 10;
                                        }else if (selected == "21 - 50"){
                                          qtd = 35;
                                        }else if (selected == "51 - 100"){
                                          qtd = 75;
                                        }else if (selected == "Mais de 100"){
                                          qtd = 100;
                                        }

                                      }
                                    ),
                                  Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    onChanged: (str) {
                                      //filtrar(str);
                                      //print(str);
                                      qtd = int.parse(str);
                                    },
                                    //autofocus: true,
                                    style: TextStyle(
                                        color: CoresDoProjeto.principal,
                                        fontFamily: "Poppins-Medium",
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                        //prefixIcon: new Icon(FontAwesomeIcons.search,color: Colors.white),
                                        hintText: "Quantidade",
                                        hintStyle: TextStyle(
                                          color: CoresDoProjeto.principal,
                                          fontFamily: "Poppins-Medium",
                                        )),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'CANCELAR',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.red),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(-1);
                              },
                              color: Colors.transparent),
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'CONFIMAR',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.teal),
                                ),
                              ),
                              onPressed: () {
                                //votarAFavor(docId, idPost);
                                adicionarResiduo(id.toString(), registro, qtd.toString(), context);
                                /*
                                if (qtd > 0) {
                                  Navigator.of(context).pop(qtd);
                                }
                                */
                              },
                              color: Colors.transparent)
                        ],
                      ),
                    ],
                  )));
        });
  }


    Future<bool> removerItem(context, int id, String tipo, String registro) {
    int qtd = 0;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  color: Colors.red),
                              child: Center(
                                child: Text(
                                  tipo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              )),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: Text("Tem certeza que deseja remover este item?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "NunitoBold",
                          )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'CANCELAR',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.red),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              color: Colors.transparent),
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'REMOVER',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.teal),
                                ),
                              ),
                              onPressed: () {
                                //votarAFavor(docId, idPost);
                                removerResiduo(id.toString(), registro, context);
                              },
                              color: Colors.transparent)
                        ],
                      ),
                    ],
                  )));
        });
  }



  Future<bool> enviarRegistrosGuardados(context) {
    
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  color: Colors.teal),
                              child: Center(
                                child: Text(
                                  "Registro Pendente",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              )),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: Text("Você tem alguns registros pendentes!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CoresDoProjeto.principal,
                            fontFamily: "NunitoBold",
                          )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'CANCELAR',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.red),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              color: Colors.transparent),
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'ENVIAR',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      color: Colors.teal),
                                ),
                              ),
                              onPressed: () {
                                //votarAFavor(docId, idPost);
                                  Navigator.of(context).pop(true);
                              },
                              color: Colors.transparent)
                        ],
                      ),
                    ],
                  )));
        });
  }
}
