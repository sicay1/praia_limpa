import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/degetos.dart';
import 'tiposDegetos.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main/index.dart';
import '../common/usuario.dart';
import '../feed/confirmacao.dart';
import 'amostragem.dart';
import '../common/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

class PostPage extends StatefulWidget {
  File image;
  String registro;
  PostPage({this.image, this.registro});
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  AnimationController _controler;
  Animation animation;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController animationController;
  Animation<double> _scaleAnimation;

  List<Degeto> listaDegetos = ListaDeConteudo.lista;

  File _image;
  int contador = 0;
  TextEditingController txtController = new TextEditingController();
  bool txtEnable = true;
  String comentario = "";
  String degetos = "";
  Position _position;
  String nome, email, imagem;
  String endereco = "";
  bool carregando = false;
  bool enviando = false;
  bool enviado = false;
  bool pegouLocalizacao = true;
  bool mostrarDegetos = false;
  List<int> listaIntDegetos = new List();

  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);

  Icon flag = Icon(FontAwesomeIcons.circle);

  double lat = 0.0;
  double lon = 0.0;


  concluirRegistro(String registro, String comentario) async {

    if (ListaDeCategorias.adicionados.isEmpty) {

      mostrarSnackBar('Informe os tipos de degetos!');

    } else{

      var res = await http.post(
        Uri.parse("${Usuario.urlBase}concluirRegistro.php"),
        body: {
          "registro": registro,
          "comentario": comentario,
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);

      if(obj == true){
        ListaDeCategorias.adicionados.clear();
        enviarItensParaLimpeza();
        
        Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => ConfirmacaoPage(regarregar: true,)),
              (Route route) => route == null);
      }else{
        print("erro");
      }
    }
     
  }

  enviarItensParaLimpeza(){
    limparLista(ListaDeCategorias.listPlastico);
    limparLista(ListaDeCategorias.listAluminio);
    limparLista(ListaDeCategorias.listFragmentos);
    limparLista(ListaDeCategorias.listMadeira);
    limparLista(ListaDeCategorias.listOrganico);
    limparLista(ListaDeCategorias.listPapel);
    limparLista(ListaDeCategorias.listVidro);
    limparLista(ListaDeCategorias.listTecido);
    limparLista(ListaDeCategorias.listAco);
  }

  limparLista(List<Tipo> lista){
    for (var item in lista) {
      setState(() {
        item.marcado = false;
          item.qtd = 0;
      });
    }
  }

  mostrarSnackBar(String msg) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg, style: estiloMensagem),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  adicionarDegeto(Degeto deg) {
    setState(() {
      listaIntDegetos.add(deg.id);
    });
  }

  adicionarTipo(Tipo deg) {
    setState(() {
      ListaDeCategorias.adicionados.add(deg);
    });
  }

  removerDegeto(Degeto deg) {
    int i = listaIntDegetos.indexOf(deg.id);
    setState(() {
      listaIntDegetos.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: w,
            height: 60.0,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Image.asset("assets/camera.png", width: 40.0, height: 40.0),
                Text("Complete seu registro",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CoresDoProjeto.principal,
                      fontFamily: "NunitoBold",
                      fontSize: 18.0,
                      //letterSpacing: 1.0
                    )),
                SizedBox(
                  width: 1.0,
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: 120.0,
              width: w,
              decoration: BoxDecoration(
                color: CoresDoProjeto.principal,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              child: Center(
                child: TextField(
                  controller: txtController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  //autofocus: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Título",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              )),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AmostragemPage(id: widget.registro)));
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Image.asset("assets/trashIcons.png"),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("Tipo de resíduos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CoresDoProjeto.principal,
                          fontFamily: "NunitoBold",
                          fontSize: 18.0,
                          //letterSpacing: 1.0
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  "assets/linha.png",
                  width: double.infinity,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                height: 30.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ListaDeCategorias.adicionados.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    Tipo degeto = ListaDeCategorias.adicionados[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 1.0),
                        child: Text(
                          index < (ListaDeCategorias.adicionados.length - 1)
                              ? degeto.tipo + ", "
                              : degeto.tipo,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: "Poppins-Medium",
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Hero(
                  tag: 'imagemRegistro',
                  child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: widget.image == null
                              ? NetworkImage(
                                  "https://avatars2.githubusercontent.com/u/20976876?s=100&v=4")
                              : FileImage(widget.image),
                          fit: BoxFit.cover)),
                ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          enviando
              ? SpinKitThreeBounce(
                  color: CoresDoProjeto.principal,
                  size: 20.0,
                  duration: Duration(milliseconds: 900),
                )
              : InkWell(
                  child: Container(
                    width: 180.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          //Color(0xFF17ead9),
                          //Color(0xFF6078ea)
                          CoresDoProjeto.principal,
                          Colors.teal,
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
                        onTap: () => concluirRegistro(widget.registro, comentario),
                        child: Center(
                          child: Text("Concluir registro",
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
            height: 10.0,
          ),
          InkWell(
            child: Container(
              width: 180.0,
              height: 40.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    //Color(0xFF17ead9),
                    //Color(0xFF6078ea)
                    CoresDoProjeto.principal,
                    Colors.teal,
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
                  onTap: () async {

                    await Future.delayed(new Duration(seconds: 2));
                    Navigator.of(context).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                        MainPage()),
                                                (Route route) => route == null);

                    final snackBar = SnackBar(
                      backgroundColor: Colors.teal,
                      content: Text('Registro salvo!', style: estiloMensagem),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  },
                  child: Center(
                    child: Text("Salvar registro",
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
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controler =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controler, curve: Curves.fastOutSlowIn));
    _controler.forward();

    animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _scaleAnimation = Tween(begin: 0.9, end: 1.0).animate(animationController);
  }
}
