import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AjudaPage extends StatefulWidget {
  @override
  _AjudaPageState createState() => _AjudaPageState();
}

class _AjudaPageState extends State<AjudaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),),
        title: Text("Ajuda", style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium",)),
        
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("Ajudamos de varias formas", style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium", fontSize: 20.0)),
          ),
        ],
      ),
    );
  }
}