import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_praia_limpa/common/drawer.dart';
import 'package:flutter_praia_limpa/common/empresa.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import '../common/modal.dart';
import 'data.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/modal.dart';
import '../common/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PerfilPage extends StatefulWidget {
  String id, nome, image;
  PerfilPage(this.id, this.nome, this.image);
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nome, email, imagem;
  int pontos = 0;
  
  int pub = 0;

  Modal m = new Modal();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  MemoryImage base64ToImage(String img) {
    return MemoryImage(base64Decode(img));
  }

  MemoryImage base64ToImageProvider(String img) {
    return MemoryImage(base64Decode(img));
  }

  buscarUsuario() async {

    print(Usuario.id);
    final pref = await SharedPreferences.getInstance();

    List<String> usuario = pref.getStringList("usuario");

    setState(() {
      nome = usuario[1];
      imagem = usuario[2];
      email = usuario[3];
    });

    buscarInformacoesUsuario();
  }

  
  buscarInformacoesUsuario() async {
    var res = await http.post(
        Uri.parse("${Usuario.urlBase}usuario.php"),
        body: {
          "usuario": Usuario.id,
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      setState(() {
        pontos = int.parse(obj['usuario']['pontos']);
        pub = int.parse(obj['usuario']['publicacao']);
      });
  }
//_scaffoldKey.currentState.openDrawer();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    DateTime hoje = DateTime.now();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
                    padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
                    child: CircleAvatar(
                      backgroundImage: base64ToImageProvider(widget.image),
                    ),
                  ),
        title: Text(
          widget.nome,
          style: TextStyle(
              fontFamily: "NunitoRegular",
              color: Colors.teal[900],
              fontSize: 26.0),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: (){
                _scaffoldKey.currentState.openDrawer();
              },
              icon: Icon(FontAwesomeIcons.bars, color: CoresDoProjeto.principal),
            )
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        maxHeight: 850.0,
          panel: Container(
              color: CoresDoProjeto.principal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset("assets/bennefits.png"),
                  Container(
        padding: EdgeInsets.only(top: 60.0),
          width: w,
          height: 450.0,
          child: ListView(
                    shrinkWrap: true,
                    children: Empresa.listaEmpresasBeneficios
                        .map((Empresa document) {
                      return GestureDetector(
                        onTap: (){
                          m.promocao(context, document.id.toString());
                        },
                          child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                height: 120.0,
                                width: w - 20.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20.0)
                                  ),
                              ),

                              Positioned(
                                top: -50.0,
                                left: ((w - 20) / 2) - 50.0,
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: base64ToImageProvider("${document.foto}"),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      );
                    }).toList(),
                  ))
                ],
              )),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      CoresDoProjeto.principal,
                      CoresDoProjeto.principal,
                      CoresDoProjeto.principal,
                    ],
                    tileMode: TileMode.clamp,
                    begin: Alignment.topLeft,
                    stops: [0.3, 0.6, 1.0],
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //Container geral
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 90.0,
                                                  width: 210.0,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/registros.png"))),
                                                ),
                                                Positioned(
                                                  left: 22.0,
                                                  top: 24.0,
                                                  child: Text(
                                                    pub.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "NunitoBold",
                                                        fontSize: 17.0),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 90.0,
                                                  width: 210.0,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/pontos.png"))),
                                                ),
                                                Positioned(
                                                  left: 22.0,
                                                  top: 24.0,
                                                  child: Text(
                                                    pontos.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "NunitoBold",
                                                        fontSize: 17.0),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        //color: Colors.transparent,
                                        width: double.infinity,
                                        height: 150.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              "ESPÉCIES SALVAS",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontFamily: "NunitoBold",
                                                  color: Colors.yellow),
                                            ),
                                            Divider(
                                              indent: 0.0,
                                              endIndent: 0.0,
                                              height: 2.0,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 60.0,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    2,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Animal animal =
                                                      Conteudo.lista[index];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                    child: Image.asset(
                                                      animal.imagem,
                                                      width: 50.0,
                                                      height: 50.0,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Divider(
                                              indent: 0.0,
                                              endIndent: 0.0,
                                              height: 2.0,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ))),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),

                          //Fim do container
                        ],
                      ),
                    ),
          )),
    );
  }

  buscarBeneficios() async {
    List<Empresa> tempListaBeneficios = new List();
    var res = await http.get(
        Uri.parse("${Usuario.urlBase}beneficios.php?id=${Usuario.id}"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);

    for (var item in objetos['beneficios']) {
      tempListaBeneficios.add(new Empresa(
          id: int.parse(item['id']),
          nome: item['nome'],
          foto: item['foto'],
          validade: item['validade'],
        ));
    }
    setState(() {
      Empresa.listaEmpresasBeneficios = tempListaBeneficios;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.buscarUsuario();
    this.buscarBeneficios();
  }

}
