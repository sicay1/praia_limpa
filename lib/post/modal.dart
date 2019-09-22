import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/degetos.dart';
class Modal {
    mostrarTipos(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListaDegetos();
        });
  }
}

class ListaDegetos extends StatefulWidget {
  
  @override
  _ListaDegetosState createState() => _ListaDegetosState();
}

class _ListaDegetosState extends State<ListaDegetos> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 400.0,
                child: ListView.builder(
                  itemCount: ListaDeConteudo.lista.length,
                  itemBuilder: (BuildContext context, int index){
                    return _createTile(context, ListaDeConteudo.lista[index]);
                  },
                ),
              ),
              SizedBox(height: 30.0,)
            ],
          );
  }

  ListTile _createTile(BuildContext context, Degeto degeto) {
    return ListTile(
      leading: Image.asset(degeto.icone),
      title: Text(degeto.titulo),
      onTap: () {
        //Navigator.pop(context);
      },
      trailing: IconButton(
        onPressed: (){
          setState(() {
            if(degeto.marcado){
              degeto.marcado = false;
            }else{
              degeto.marcado = true;
              //degetos(degeto.titulo);
            }
          });
          print("adicionado");
        },
        icon: 
        !degeto.marcado ?
        Icon(FontAwesomeIcons.circle)
        :
        Icon(FontAwesomeIcons.check, color: Colors.green,)
      ),
    );
  }
}

//_createTile(context, 'Garrafas pet', FontAwesomeIcons.beer,Colors.red),