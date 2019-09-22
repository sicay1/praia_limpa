import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/registro.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../main/index.dart';
import '../common/colors.dart';
import 'package:http/http.dart' as http;

class ConfirmacaoPage extends StatefulWidget {
  bool regarregar;

  ConfirmacaoPage({this.regarregar});
  @override
  _ConfirmacaoPageState createState() => _ConfirmacaoPageState();
}

class _ConfirmacaoPageState extends State<ConfirmacaoPage> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CoresDoProjeto.principal,
      body: Container(
      
      height: h,
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Text("Obrigado!",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins-Medium",
              fontSize: 35.0
            )),
        )
        
        
        
      ),
    ),
    );
  }

  mudar() async {
    await Future.delayed(new Duration(seconds: 2));
    Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()),
                                (Route route) => route == null);
  }

  mudarSemEsperar() async {
    Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()),
                                (Route route) => route == null);
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

    print("entou no recarregamento da lista de registro");
    
    List<Registro> tempListaRegistros = new List();
    var res = await http.get(
        Uri.parse("${Usuario.urlBase}registros.php"),
        headers: {"Accept": "application/json"});

    var objetos = json.decode(res.body);


    for (var item in objetos['registros']) {

      int categoria = 0;
      try{
        categoria = int.parse(item['residuos'][0]['categoria']);
      }catch(e){
        categoria = 1;
      }
      
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
          icone: selecionarIcone(categoria)
        ));
    }
    
    setState(() {
      Registro.listaRegistros = tempListaRegistros; 
      mudarSemEsperar();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    
    
    super.initState();


    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    animationController.forward();

    print("${widget.regarregar} este é o valor enciardo");

    if(widget.regarregar != null && widget.regarregar == true){
      buscarRegistrosSql();
      
    }else{
      mudar();
    }
    
  }
}