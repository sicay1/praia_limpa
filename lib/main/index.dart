import 'package:flutter/material.dart';
import '../feed/index.dart' as feed;
import '../mapa/index.dart' as mapa;
import '../perfil/index.dart' as perfil;
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  double latitudeMapa;
  double longitudeMapa;

  MainPage({this.latitudeMapa, this.longitudeMapa});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  

  //Widget page = mapa.MapaPage();
  Widget page = Container();
  int _count = 0;
  String asset = "assets/bottomMenu/mapa_.png";

  String id, nome, email, imagem;

  buscarUsuario() async {
    final pref = await SharedPreferences.getInstance();

    List<String> usuario = pref.getStringList("usuario");

    setState(() {
      id = usuario[0];
      nome = usuario[1];
      imagem = usuario[2];
      email = usuario[3];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarUsuario();
    page = mapa.MapaPage(latitudeMapa: widget.latitudeMapa, longitudeMapa: widget.longitudeMapa,);
    
    
  }

  Widget barraDeNavegacao(double largura){

    return Container(
            key: ValueKey<int>(2),
            height: 70.0,
            width: largura,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(asset),
                fit: BoxFit.fill
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    print("1");

                    setState(() {
                      asset = "assets/bottomMenu/registros_.png";
                      page = feed.FeedPage();
                    });
                  },
                  child: Container(
                    height: 70.0,
                    width: largura / 3,
                    color: Colors.transparent,
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    print("2");

                    setState(() {
                      asset = "assets/bottomMenu/mapa_.png";

                      page = mapa.MapaPage();
                    });
                  },
                  child: Container(
                    height: 70.0,
                    width: largura / 3,
                    color: Colors.transparent,
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    print("3");

                    setState(() {
                      asset = "assets/bottomMenu/perfil_.png";
                      page = perfil.PerfilPage(id, nome, imagem);
                    });
                  },
                  child: Container(
                    height: 70.0,
                    width: largura / 3,
                    color: Colors.transparent,
                  ),
                ),


              ],
            ),
          );
  }

  


  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double largura = MediaQuery.of(context).size.width;

    return Container(
      height: altura,
      width: largura,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: altura - 70.0,
            width: largura,
            child: page,
          ),
          barraDeNavegacao(largura)
        ],
      ),
    );
  }
}


/*

Container(
            height: 70.0,
            width: lagura,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/bottomMenu/mapa_.png"),
                fit: BoxFit.fill
              )
            ),
          )

*/