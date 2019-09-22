import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/empresa.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BeneficiosPage extends StatefulWidget {
  @override
  _BeneficiosPageState createState() => _BeneficiosPageState();
}

class _BeneficiosPageState extends State<BeneficiosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final estiloMensagem = TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);
  bool enviando = false;
  List<Empresa> listaEmpresas = new List();


  MemoryImage base64ToImageProvider(String img) {
    return MemoryImage(base64Decode(img));
  }

  mostrarSnackBar(String msg, Color cor){
    final snackBar = SnackBar(
          backgroundColor: cor,
          content: Text(
            msg,
            style: estiloMensagem,
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  adicionarBeneficio(String empresa, String desconto) async {
    setState(() {
      enviando = true;
    });
    var res = await http.post(
        Uri.parse("${Usuario.urlBase}adicionarBeneficio.php"),
        body: {
          "usuario": Usuario.id,
          "empresa": empresa,
          "desconto": desconto,
          },
        headers: {"Accept": "application/json"});

      var obj = json.decode(res.body);
      setState(() {
        enviando = false;
      });
      if(obj == true){
        mostrarSnackBar('Beneficio registrado!', Colors.teal);
      }else{
        mostrarSnackBar('Você não tem pontos suficientes!', Colors.red);
      }
      
  }

  buscarEmpresas() async {
      List<Empresa> tempListaEmpresas = new List();
      var res = await http.get(Uri.parse("${Usuario.urlBase}empresas.php"),
          headers: {"Accept": "application/json"});

      var objetos = json.decode(res.body);

      for (var item in objetos['empresas']) {
        //print(item['registro']['foto']);
        tempListaEmpresas.add(new Empresa(
          id: int.parse(item['id']),
          nome: item['nome'],
          foto: item['foto'],
          beneficios: int.parse(item['beneficios']),
        ));
      }

      setState(() {
        listaEmpresas = tempListaEmpresas;
      });
    }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Beneficios",
            style: TextStyle(
              color: CoresDoProjeto.principal,
              fontFamily: "NunitoBold",
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon:
              Icon(FontAwesomeIcons.arrowLeft, color: CoresDoProjeto.principal),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 10.0),
          width: w,
          height: h,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    CoresDoProjeto.principal,
                    Colors.teal,
                    Colors.white,
                  ],
                  tileMode: TileMode.clamp,
                  begin: Alignment.topLeft,
                  stops: [0.3, 0.6, 1.0],
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: !enviando
              ? ListView(
                          shrinkWrap: true,
                          children: listaEmpresas
                              .map((Empresa document) {
                            return ListTile(
                              leading: Container(
                                  height: 55.0,
                                  width: 55.0,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius:
                                              1.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              1.0, // has the effect of extending the shadow
                                          offset: Offset(
                                            1.0, // horizontal, move right 10
                                            1.0, // vertical, move down 10
                                          ),
                                        )
                                      ],
                                      border: Border.all(
                                          width: 3.0,
                                          color: Colors.white.withOpacity(0.8)),
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                              base64ToImageProvider(document.foto),
                                          fit: BoxFit.fill))),
                              title: Text(document.nome,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19.0,
                                    fontFamily: "NunitoLight",
                                  )),
                              subtitle: Container(),

                              trailing: IconButton(
                                icon: Icon(FontAwesomeIcons.calendarAlt, color: Colors.white,),
                                onPressed: (){
                                  adicionarBeneficio(document.id.toString(), "10");
                                },
                              ),
                            );
                          }).toList(),
                        )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitThreeBounce(
                      color: Colors.white,
                      size: 20.0,
                      duration: Duration(milliseconds: 900),
                    ),
                    Text('Aguarde um momento...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontFamily: "NunitoRegular",
                        ))
                  ],
                ))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.buscarEmpresas();
  }
}
