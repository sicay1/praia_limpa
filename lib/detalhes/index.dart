import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_praia_limpa/common/registro.dart';
import 'package:flutter_praia_limpa/common/sanar.dart';
import 'package:flutter_praia_limpa/common/usuario.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetalhesPage extends StatefulWidget {
  Registro document;
  String imagemAutor;
  bool sanar;
  DetalhesPage(this.document, this.sanar, this.imagemAutor);
  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  MemoryImage base64ToImageProvider(String img) {
    return MemoryImage(base64Decode(img));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CoresDoProjeto.principal,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
        ),
        title: Text(widget.document.nomeAutor,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "NunitoBold",
            )),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                CoresDoProjeto.principal,
                Colors.teal,
                Colors.white,
              ],
              tileMode: TileMode.mirror,
              begin: Alignment.topLeft,
              stops: [0.3, 0.6, 1.0],
              end: Alignment.bottomRight),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius:
                          20.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    )
                  ]),
              width: w - 40.0,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2.0),
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: base64ToImageProvider(widget.imagemAutor)),
                          ),
                        ),
                      ),
                      Text(
                        widget.document.nomeAutor,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontFamily: "NunitoLight",
                            fontSize: 20.0),
                      ),

                      widget.sanar ? 

                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: GestureDetector(
                                onTap: (){
                                  if(widget.sanar){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => SanarPage(widget.document.id)));
                                  }
                                },
                                
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/clean_ac.png")
                                    )
                                  ),
                                ),
                                //icon: Icon(FontAwesomeIcons.checkCircle, color: Colors.green, size: 30.0,),
                              )
                              )
                              
                              
                              :
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/clean_in.png")
                                    )
                                  ),
                                ),
                              )
                              
                            
                    ],
                  ),

                  SizedBox(height: 10.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Container(
                      height: 350.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10.0),
                        color: CoresDoProjeto.principal,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage("${Usuario.urlBase}/uploads/${widget.document.imagemPost}")),
                      ),
                    ),
                  ), 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                              widget.document.comentario,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0, fontFamily: "NunitoRegular"),
                            ),
                  ), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
