import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/registro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../main/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../common/usuario.dart';
import 'package:http/http.dart' as http;

class MeusPostsPage extends StatefulWidget {
  @override
  _MeusPostsPageState createState() => _MeusPostsPageState();
}

class _MeusPostsPageState extends State<MeusPostsPage> {


    MemoryImage base64ToImageProvider(String img) {
      return MemoryImage(base64Decode(img));
    }

  String formatarHoraStr(String time) {
    String res = time.substring(0,10);
    var str = res.split("-");


    return str[2] + "/" + str[1] + "/" + str[0];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CoresDoProjeto.principal,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            /*
            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainPage()));

                          */
          },
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),),
        title: Text("Meus Registros", style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium",)),
        
      ),

      body:  ListView(
                  children: Registro.listaMeusRegistros.map((Registro document) {
                    
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
                      child: Container(
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white
                      ),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${Usuario.urlBase}/uploads/${document.imagemPost}")
                              )
                            ),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                          child: Text(
                            document.comentario,
                            style: TextStyle(color: Colors.black, fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            formatarHoraStr(document.dataStr),
                            style: TextStyle(color: Colors.blueGrey[700]),
                          ),
                        ),
                        SizedBox(height: 5.0,)
                      ],
                    )
                    ),
                    );
                  }).toList(),
                ),
    );
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

  buscarRegistrosSql() async {
    
    List<Registro> tempListaRegistros = new List();
    var res = await http.get(
        Uri.parse("${Usuario.urlBase}meusRegistros.php?id=${Usuario.id}"),
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
      Registro.listaMeusRegistros = tempListaRegistros;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(Usuario.id);
    buscarRegistrosSql();
  }
}