import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/colors.dart';

class DoePage extends StatefulWidget {
  @override
  _DoePageState createState() => _DoePageState();
}

class _DoePageState extends State<DoePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CoresDoProjeto.principal,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: CoresDoProjeto.principal,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
          ),
          title: Text("Doe",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "NunitoBold",
              )),
        ),
        body: Container(
          decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            CoresDoProjeto.principal,
                            Colors.teal,
                            Colors.white,
                          ],
                          tileMode: TileMode.clamp,
                          begin: Alignment.topLeft,
                          stops: [0.1, 0.7, 1.0],
                          end: Alignment.bottomRight
                          ),
                      ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("Contribua com o Mar Limpo",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "NunitoBold",
                        fontSize: 20.0)),
              ),
              Center(
                child: Text("Agência: 1533-4",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "NunitoBold",
                        fontSize: 18.0)),
              ),
              Center(
                child: Text("Conta Corrente: 50033-X",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "NunitoBold",
                        fontSize: 18.0)),
              ),
            ],
          ),
        ));
  }
}
