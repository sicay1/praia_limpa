import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Modal {
  promocao(BuildContext context, String codigo) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  QrImage(
                    data: codigo,
                    size: 200.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("-15%",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 40.0,
                  )
                ],
              ));
        });
  }

  comentar(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration:
                  BoxDecoration(
                    //borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue,
                  ),
                  
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: w,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          width: w - 40.0,
                          child: TextField(
                            //controller: txtController,
                            //onChanged: ((str) {
                            //}),
                            //keyboardType: TextInputType.multiline,
                            //maxLines: 3,
                            autofocus: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Comentário",
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),

                        Container(
                          width: 40.0,
                          child: IconButton(
                            onPressed: (){

                            },
                            icon: Icon(FontAwesomeIcons.paperPlane, color: Colors.white,),
                          )
                        )

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 240.0,
                  )
                ],
              ));
        });
  }
}
