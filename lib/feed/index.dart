import 'dart:ui' as prefix0;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/registro.dart';
import 'package:flutter_praia_limpa/detalhes/index.dart';
import 'package:flutter_praia_limpa/main/index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/drawer.dart';
import 'dart:convert';
import '../common/usuario.dart';
import '../common/confirm.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'motivoNegacao.dart';
import '../common/modal.dart';
import '../common/colors.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);
  Confirm c = new Confirm();
  Modal m = new Modal();

  List<Registro> listaRegistros = new List();



  Image base64ToImage(String img) {
    return Image.memory(base64Decode(img));
  }

  MemoryImage base64ToImageProvider(String img) {
    return MemoryImage(base64Decode(img));
  }

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

  String formatarHoraStr(String time) {
    String res = time.substring(0,10);
    var str = res.split("-");


    return str[2] + "/" + str[1] + "/" + str[0];
  }

  validarSql(Registro registro) async {
    setState(() {
      registro.verificando = true;
    });
    var res = await http.post(
        Uri.parse("${Usuario.urlBase}verificarVoto.php"),
        body: {
          "registro": registro.id,
          "usuario": Usuario.id,
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      print(obj);

      
    try{
        if(int.parse(obj['qtd']) > 0){
          print("ja votou");
          mostrarSnackBar('Você já validou este registro');
        }
      }catch(e) {
        print("nao votou");

        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MotivoNegacaoPage(registro.id,"",0,0,"")));
      }

    setState(() {
      registro.verificando = false;
    });
      
  }

    BitmapDescriptor selecionarIcone(int id) {
    switch (id) {
      case 1:
          return BitmapDescriptor.fromAsset('assets/pins/vermelho.png');    
        break;
      case 2:
          return BitmapDescriptor.fromAsset('assets/pins/vermelho.png');    
        break;
      case 3:
          return BitmapDescriptor.fromAsset('assets/pins/marrom.png');    
        break;
      case 4:
          return BitmapDescriptor.fromAsset('assets/pins/verde.png');    
        break;
      case 5:
          return BitmapDescriptor.fromAsset('assets/pins/amarelo.png');    
        break;
      case 6:
          return BitmapDescriptor.fromAsset('assets/pins/amarelo.png');    
        break;
      case 7:
          return BitmapDescriptor.fromAsset('assets/pins/azul.png');    
        break;
      case 8:
          return BitmapDescriptor.fromAsset('assets/pins/marrom.png');    
        break;

      default:
        return BitmapDescriptor.fromAsset('assets/pins/marrom.png');    
    }
    
  }

    Future<void> buscarRegistrosSql() async {
    
    List<Registro> tempListaRegistros = new List();
    var res = await http.get(
        Uri.parse("${Usuario.urlBase}registros.php"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);


    for (var item in objetos['registros']) {

      print(int.parse(item['residuos'][0]['categoria']));
      tempListaRegistros.add(new Registro(
        
          id: item['registro']['registro_id'],
          nomeAutor: item['registro']['nome'],
          comentario: item['registro']['comentario'],
          dataStr: item['registro']['data_registro'],
          imagemPost: item['registro']['imagem'],
          imagemAutor: item['registro']['foto'],
          latitude: double.parse(item['registro']['latitude']),
          longitude: double.parse(item['registro']['longitude']),
          verificando: false,
          icone: selecionarIcone(int.parse(item['residuos'][0]['categoria']))
        ));
    }
    
    setState(() {
      Registro.listaRegistros = tempListaRegistros;
    });
  }


  @override
  Widget build(BuildContext context) {

    //CollectionReference col = Firestore.instance.collection('postagem');

    //Query vtf = col.where("votos_a_favor", isLessThan: 3);
    //Query vtc = vtf.where("votos_contra", isLessThan: 5);

    return Scaffold(
      
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          
        ),
        backgroundColor: CoresDoProjeto.principal,
        
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.bars,
              color: CoresDoProjeto.principal,
            ),
            onPressed: () {}),
        
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer())
        ],
        title: Image.asset("assets/logo_b.png", width: 150.0,),
        
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.2, 0.4, 0.9],
                    colors: [
                      Color.fromRGBO(170, 228, 221, 1.0),
                      Color.fromRGBO(180, 240, 250, 1.0),
                      Color.fromRGBO(255, 255, 255, 1.0),
                      Color.fromRGBO(255, 255, 255, 1.0),
                    ],
                  ),
                ),

                child: LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  color: CoresDoProjeto.principal,
                  onRefresh: buscarRegistrosSql,
                  child: ListView.builder(itemCount: Usuario.testeProducao ? listaRegistros.length :  Registro.listaRegistros.length, itemBuilder: (BuildContext context, int index){
                  Registro registro = Usuario.testeProducao ? listaRegistros[index] :  Registro.listaRegistros[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
                      child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.transparent
                      ),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 10.0, 8.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: base64ToImageProvider(registro.imagemAutor)),
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        registro.nomeAutor,
                                        style: TextStyle(color: Colors.teal[900], fontFamily: "NunitoRegular", fontSize: 20.0)
                                      ),
                                      
                                      Text(
                                        formatarHoraStr(registro.dataStr),
                                          style: TextStyle(color: Colors.black, fontSize: 13.0),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () async {
                              double distanceInMeters = await Geolocator().distanceBetween(registro.latitude, registro.longitude, Usuario.lat, Usuario.lon);
                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) => DetalhesPage(registro, distanceInMeters < 15.0, registro.imagemAutor)));
                            },
                            child: Container(
                                    height: 200,
                                    width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: CoresDoProjeto.principal,
                                        borderRadius: BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage("${Usuario.urlBase}/uploads/${registro.imagemPost}"),
                                        )
                                      ),
                                    ),
                          ),
                        ),
                        

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4.0),
                          child: Text(
                            registro.comentario,
                            style: TextStyle(color: Colors.black, fontSize: 18.0, fontFamily: "NunitoRegular"),
                          ),
                        ),
                        /*
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            formatarHora(document['date_time']),
                            style: TextStyle(color: Colors.blueGrey[700]),
                          ),
                        ),
                        */
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    MainPage(latitudeMapa: registro.latitude, longitudeMapa: registro.longitude,)),
                                            (Route route) => route == null);
                                },
                                child: Container(
                                height: 25.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/pins/vermelho.png')
                                  )
                                ),
                              ),

                              ),
                              
                              /*
                              IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.mapMarkedAlt,
                                          color: Colors.red,
                                          size: 25.0,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    MainPage(latitudeMapa: registro.latitude, longitudeMapa: registro.longitude,)),
                                            (Route route) => route == null);
                                        },
                                      ),
                                      */
                                      SizedBox(width: 4.0,),

                              !registro.verificando ?
                              
                              registro.idAutor != Usuario.id ? 
                                  
                                  Row(
                                    children: <Widget>[
                                      
                                      IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.check,
                                          color: Colors.green,
                                          size: 25.0,
                                        ),
                                        onPressed: () {
                                          Usuario.testeProducao ?
                                          (){} : validarSql(registro);
                                        },
                                      ),
                                      Text("Valide o registro", style: TextStyle(fontSize: 18.0, fontFamily: "NunitoBold"),)
                                    ],
                                  )

                                      :

                                      Container()
                                      
                                      :
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: SizedBox(
                                              height: 30.0,
                                              width: 30.0,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                                backgroundColor: Colors.grey,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0,)
                      ],
                    ),
                    ),
                    );
                  },
                ),
                )
              ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}