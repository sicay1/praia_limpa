import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/degetos.dart';
import 'index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../common/colors.dart';
import 'confirmacao.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class MotivoNegacaoPage extends StatefulWidget {
  String docId, idPost, idCriador;
  int votosAFavor, votosContra;
  MotivoNegacaoPage(this.docId, this.idPost, this.votosAFavor, this.votosContra, this.idCriador);

  @override
  _MotivoNegacaoPageState createState() => _MotivoNegacaoPageState();
}

class _MotivoNegacaoPageState extends State<MotivoNegacaoPage> {
  int motivoSelecionado = -1;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);
  bool carregando = false;
  String res = "RESULTADO";
  int pontos = 0;
  int cont = 0;

  bool p1u = false;
  bool p1d = false;
  int p1 = 0;
  int c1 = 0;

  bool p2u = false;
  bool p2d = false;
  int p2 = 0;
  int c2 = 0;

  bool p3u = false;
  bool p3d = false;
  int p3 = 0;
  int c3 = 0;

  bool p4u = false;
  bool p4d = false;
  int p4 = 0;
  int c4 = 0;
//'Por favor, responda todas as perguntas do questionamento!'
  mostrarSnackBar(String msg){
    final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            msg,
            style: estiloMensagem,
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  mudar() async {
    await Future.delayed(new Duration(seconds: 2));
    Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ConfirmacaoPage()),
                                (Route route) => route == null);
  }

  votarSql() async {
    String voto;
    if(pontos >= 4){
      voto = "1";
    }else{
      voto = "0";
    }
    if(cont < 4){
      mostrarSnackBar('Por favor, responda todas as perguntas do questionamento!');
    }else{
      setState(() {
          carregando = true;
      });
      var res = await http.post(
        Uri.parse("${Usuario.urlBase}adicionarVoto.php"),
        body: {
          "registro": widget.docId,
          "usuario": Usuario.id,
          "voto": voto
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);

      if(obj){
        mudar();
      }
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CoresDoProjeto.principal,
      appBar: AppBar(
        title: Text("Validação",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins-Medium",
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
        ),
        actions: <Widget>[
          carregando
              ? SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20.0,
                  duration: Duration(milliseconds: 900),
                )
              : FlatButton(
                  onPressed: () {
                    votarSql();
                  },
                  child: Text("ENVIAR",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins-Medium",
                        fontSize: 18,
                        //letterSpacing: 1.0
                      )),
                )
        ],
        elevation: 0.0,
        backgroundColor: CoresDoProjeto.principal,
        //title: Text("Motivo", style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Padding(
          //padding: EdgeInsets.symmetric(horizontal: 10.0),
          //child: Text("Por que esse registro não deve ser publicado?", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Poppins-Medium"),),
          //),

          SizedBox(
            height: 10.0,
          ),

          Flexible(
            child: ListView(
              children: <Widget>[

                //comeca uma nova tile

                ListTile(
                  title: Text("1- A imagem contem nudez?",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              p1d = true;
                              p1u = false;
                              p1 = 1;
                              
                              pontos = p1 + p2 + p3 + p4;
                              c1 = 1;
                              cont = c1 + c2 + c3 + c4;
                              
                            });
                          },
                          child:
                              p1d == false
                                  ? Icon(FontAwesomeIcons.thumbsDown,
                                      color: Colors.white)
                                  : Icon(FontAwesomeIcons.solidThumbsDown,
                                      color: Colors.white)
                          ),
                      FlatButton(
                          onPressed: () {

                            setState(() {
                              p1d = false;
                              p1u = true;
                              p1 = 0;

                              pontos = p1 + p2 + p3 + p4;
                              c1 = 1;
                              cont = c1 + c2 + c3 + c4;
                              
                            });
                          },
                          child: 
                          
                          p1u == false
                              ? Icon(FontAwesomeIcons.thumbsUp,
                                  color: Colors.white)
                              : Icon(FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.white)
                          ),
                    ],
                  ),
                ),

                //fim da nova tile


                //comeca uma nova tile

                ListTile(
                  title: Text("2- A imagem está no padrão?",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {

                            setState(() {
                              p2d = true;
                              p2u = false;
                              p2 = 0;

                              pontos = p1 + p2 + p3 + p4;
                              c2 = 1;
                              cont = c1 + c2 + c3 + c4;
                              
                            });

                              

                          },
                          child:
                              p2d == false
                                  ? Icon(FontAwesomeIcons.thumbsDown,
                                      color: Colors.white)
                                  : Icon(FontAwesomeIcons.solidThumbsDown,
                                      color: Colors.white)
                          ),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              p2d = false;
                              p2u = true;
                              p2 = 1;

                              pontos = p1 + p2 + p3 + p4;
                              c1 = 2;
                              cont = c1 + c2 + c3 + c4;
                              
                            });

                            
                            
                          },
                          child: 
                          
                          p2u == false
                              ? Icon(FontAwesomeIcons.thumbsUp,
                                  color: Colors.white)
                              : Icon(FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.white)
                          ),
                    ],
                  ),
                ),

                //fim da nova tile


                //comeca uma nova tile

                ListTile(
                  title: Text("3- A imagem é na praia ou no mangue?",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {

                            setState(() {
                              p3d = true;
                              p3u = false;
                              p3 = 0;

                              pontos = p1 + p2 + p3 + p4;
                              c3 = 1;
                              cont = c1 + c2 + c3 + c4;
                              
                            });

                              

                          },
                          child:
                              p3d == false
                                  ? Icon(FontAwesomeIcons.thumbsDown,
                                      color: Colors.white)
                                  : Icon(FontAwesomeIcons.solidThumbsDown,
                                      color: Colors.white)
                          ),
                      FlatButton(
                          onPressed: () {

                            setState(() {
                              p3d = false;
                              p3u = true;
                              p3 = 1;

                              pontos = p1 + p2 + p3 + p4;
                              c3 = 1;
                              cont = c1 + c2 + c3 + c4;
                            });
                              
                          },
                          child: 
                          
                          p3u == false
                              ? Icon(FontAwesomeIcons.thumbsUp,
                                  color: Colors.white)
                              : Icon(FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.white)
                          ),
                    ],
                  ),
                ),

                //fim da nova tile

                //comeca uma nova tile

                ListTile(
                  title: Text("4- Contêm resíduos sólidos ou esgoto?",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {

                            setState(() {
                              p4d = true;
                              p4u = false;
                              p4 = 0;

                              pontos = p1 + p2 + p3 + p4;
                              c4 = 1;
                              cont = c1 + c2 + c3 + c4;
                              
                            });
                              
                          },
                          child:
                              p4d == false
                                  ? Icon(FontAwesomeIcons.thumbsDown,
                                      color: Colors.white)
                                  : Icon(FontAwesomeIcons.solidThumbsDown,
                                      color: Colors.white)
                          ),
                      FlatButton(
                          onPressed: () {

                            setState(() {
                              p4d = false;
                              p4u = true;
                              p4 = 1;

                              pontos = p1 + p2 + p3 + p4;
                              c4 = 1;
                              cont = c1 + c2 + c3 + c4;
                              
                            });
                              
                          },
                          child: 
                          
                          p4u == false
                              ? Icon(FontAwesomeIcons.thumbsUp,
                                  color: Colors.white)
                              : Icon(FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.white)
                          ),
                    ],
                  ),
                ),

                //fim da nova tile




              ],
            )
            /*
            ListView.builder(
              itemCount: ListaDeConteudo.listaMotivos.length,
              itemBuilder: (BuildContext context, int index) {
                Motivo motivo = ListaDeConteudo.listaMotivos[index];

                return ListTile(
                  title: Text(
                    motivo.motivo != null
                        ? "${index + 1}- ${motivo.motivo}"
                        : "Motivo",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () => chooDown(index),
                          child:
                              ListaDeConteudo.listaMotivos[index].down == false
                                  ? Icon(FontAwesomeIcons.thumbsDown,
                                      color: Colors.white)
                                  : Icon(FontAwesomeIcons.solidThumbsDown,
                                      color: Colors.white)

                          //Text("NÃO",  style: TextStyle(color: Colors.white, fontSize: 14.0)),
                          ),
                      FlatButton(
                          onPressed: () => chooUp(index),
                          child: ListaDeConteudo.listaMotivos[index].up == false
                              ? Icon(FontAwesomeIcons.thumbsUp,
                                  color: Colors.white)
                              : Icon(FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.white)

                          //Text("SIM",  style: TextStyle(color: Colors.white, fontSize: 14.0)),
                          ),
                    ],
                  ),
                  onTap: () {
                    //marcarMotivo(index);
                  },
                );
              },
            ),

            */


          ),

          Text(res,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins-Medium",
                fontSize: 18,
                //letterSpacing: 1.0
              )),
              
          Text("$pontos",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins-Medium",
                fontSize: 18,
                //letterSpacing: 1.0
              )),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      ListaDeConteudo.listaMotivos[0].down == false;
      ListaDeConteudo.listaMotivos[0].up == false;

      ListaDeConteudo.listaMotivos[1].down == false;
      ListaDeConteudo.listaMotivos[1].up == false;

      ListaDeConteudo.listaMotivos[2].down == false;
      ListaDeConteudo.listaMotivos[2].up == false;

      ListaDeConteudo.listaMotivos[3].down == false;
      ListaDeConteudo.listaMotivos[3].up == false;  
    });
  }
}
