import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmpresasPage extends StatefulWidget {
  @override
  _EmpresasPageState createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text("Parceiros",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "NunitoBold",
              ))),
      body: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemExtent: 80.0,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
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
                          width: 3.0, color: Colors.white.withOpacity(0.8)),
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/nau.jpg"),
                          fit: BoxFit.fill))),
              title: Text("Camaroes",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19.0,
                    fontFamily: "NunitoLight",
                  )),

              subtitle: Text("4 - 10 Reservas",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: "NunitoLight",
                  )),
              trailing: IconButton(
                onPressed: (){

                },

                icon: Icon(FontAwesomeIcons.calendarAlt),
              ),
            );
          },
        ),
      ),
    );
  }
}
