import 'package:flutter/material.dart';
import 'package:sticky_header_list/sticky_header_list.dart';
import '../common/degetos.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/confirm.dart';
import '../common/colors.dart';
import 'package:expandable/expandable.dart';

class AmostragemPage extends StatefulWidget {
  String id;

  AmostragemPage({this.id});
  @override
  _AmostragemPageState createState() =>
      _AmostragemPageState();
}

class _AmostragemPageState extends State<AmostragemPage> {
  static String bartitle = "Tipo de Resíduos";
  Confirm confirm = new Confirm();

  formatarText(String str) {
    if (str.length < 25) {
      return str;
    } else {
      return str.substring(0, 26) + "...";
    }
  }

  gerarExpendable(double w, double h, String titulo, List<Tipo> lista) {
    return ExpandablePanel(
      header: Column(
        children: <Widget>[
          Text(
            titulo,
            style: TextStyle(
                color: Colors.white, fontFamily: "NunitoBold", fontSize: 17.0),
          ),
          Divider(
            color: Colors.white,
            height: 8.0,
          )
        ],
      ),
      expanded: Container(
        height: 300.0,
        width: w,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            Tipo cat = lista[index];

            return ListTile(
              //leading: Image.asset(cat.imagePath),
              onTap: () async {
                if (cat.marcado == false) {
                  int qtd =
                      await confirm.quantificarItem(context, cat.id, cat.tipo, widget.id);

                  if (qtd != -1) {
                    setState(() {
                      cat.marcado = true;
                      cat.qtd = qtd;
                      ListaDeCategorias.adicionados.add(cat);
                    });
                  } else {
                    setState(() {
                      cat.marcado = false;
                      cat.qtd = 0;
                    });
                  }
                } else {
                  bool remover =
                      await confirm.removerItem(context, cat.id, cat.tipo, widget.id);

                  if (remover) {
                    int i = ListaDeCategorias.adicionados.indexOf(cat);
                    print(i);
                    setState(() {
                      ListaDeCategorias.adicionados.removeAt(i);
                      cat.marcado = false;
                      cat.qtd = 0;
                      print(ListaDeCategorias.adicionados.length);
                    });
                  }
                }
              },
              leading: cat.marcado
                  ? Icon(FontAwesomeIcons.check, color: Colors.white)
                  : null,
              title: Text(formatarText(cat.tipo),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins-Medium",
                  )),
              trailing: cat.marcado
                  ? Text("${cat.qtd}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Medium",
                          fontSize: 19.0))
                  : null,
            );
          },
        ),
      ),
      tapHeaderToExpand: true,
      tapBodyToCollapse: true,
      hasIcon: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          /*
          leading: new IconButton(
            icon: new Icon(FontAwesomeIcons.check,
                color: CoresDoProjeto.principal),
            onPressed: () => Navigator.of(context).pop(),
          ),
          */
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("CONCLUIR", style: TextStyle(
                color: CoresDoProjeto.principal, fontFamily: "NunitoBold"),),
            )
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Tipo de Resíduo",
            style: TextStyle(
                color: CoresDoProjeto.principal, fontFamily: "NunitoRegular"),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                color: CoresDoProjeto.principal,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20.0,
                    ),
                    topRight: Radius.circular(
                      20.0,
                    ))),
            child: Column(
              children: <Widget>[
                gerarExpendable(w, h, "Plástico", ListaDeCategorias.listPlastico),
                gerarExpendable(w, h, "Fragmentos", ListaDeCategorias.listFragmentos),
                gerarExpendable(w, h, "Madeira", ListaDeCategorias.listMadeira),
                gerarExpendable(w, h, "Vidro", ListaDeCategorias.listVidro),
                gerarExpendable(w, h, "Aço", ListaDeCategorias.listAco),
                gerarExpendable(w, h, "Alumínio", ListaDeCategorias.listAluminio),
                gerarExpendable(w, h, "Papel", ListaDeCategorias.listPapel),
                gerarExpendable(w, h, "Orgânico", ListaDeCategorias.listOrganico),
              ],
            )));
  }
}
