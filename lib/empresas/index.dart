
import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/empresa.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmpresasPage extends StatefulWidget {
  @override
  _EmpresasPageState createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool enviando = false;
  List<Empresa> listaEmpresas = new List();


  MemoryImage base64ToImageProvider(String img) {
    return MemoryImage(base64Decode(img));
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
        title: Text("Parceiros",
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
                    Text('Estamos registrando sua reserva',
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
