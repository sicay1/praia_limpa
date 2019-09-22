import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/degetos.dart';

class TiposDegetosPage extends StatefulWidget {
  Function add;
  Function remove;

  TiposDegetosPage(this.add, this.remove);
  @override
  _TiposDegetosPageState createState() => _TiposDegetosPageState(ListaDeConteudo.lista);
}

class _TiposDegetosPageState extends State<TiposDegetosPage> {
  static String bartitle = "Tipos de Degetos";


  List<Degeto> listaDegetos;
  _TiposDegetosPageState(this.listaDegetos);
  
  Widget appBarTitle = Text(bartitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
  Icon actionIcon = Icon(FontAwesomeIcons.search);

  
  filtrar(String str){
    listaDegetos = ListaDeConteudo.lista;
    List<Degeto> tempListaDegetos = new List();

    for (var item in listaDegetos) {
      if(item.titulo.toLowerCase().contains(str.toLowerCase())){
        tempListaDegetos.add(item);
      }
    }
    setState(() {
      listaDegetos = tempListaDegetos;
    });
  }

  

    ListTile _createTile(BuildContext context, Degeto degeto) {
    return ListTile(
      leading: Image.asset(degeto.icone),
      title: Text(degeto.titulo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.0),),
      onTap: () {
        setState(() {
            if(degeto.marcado){
              degeto.marcado = false;
              
              widget.remove(degeto);
              
              int i = ListaDeConteudo.listaDegetos.indexOf(degeto);
              setState(() {
                ListaDeConteudo.listaDegetos.removeAt(i);
              });
              
            }else{
              degeto.marcado = true;
              ListaDeConteudo.listaDegetos.add(degeto);
              //widget.add += "${degeto.titulo} "; 
              //print(widget.add);
              widget.add(degeto);
            }
          });
        //Navigator.pop(context);
      },
      trailing: IconButton(
        onPressed: (){
          setState(() {
            if(degeto.marcado){
              degeto.marcado = false;
              widget.remove(degeto.titulo);
            }else{
              degeto.marcado = true;
              ListaDeConteudo.listaDegetos.add(degeto);
              //widget.add += "${degeto.titulo} "; 
              //print(widget.add);
              widget.add(degeto.titulo);
            }
          });
          
          print("adicionado");
          
        },
        icon: 
        !degeto.marcado ?
        Icon(FontAwesomeIcons.circle)
        :
        Icon(FontAwesomeIcons.check, color: Colors.white,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(FontAwesomeIcons.check, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title:appBarTitle,
          actions: <Widget>[
            new IconButton(icon: actionIcon,onPressed:(){
            setState(() {
                      if ( this.actionIcon.icon == FontAwesomeIcons.search){
                        this.actionIcon = new Icon(FontAwesomeIcons.times);
                        this.appBarTitle = new TextField(
                          onChanged: (str){
                            filtrar(str);
                          },
                          autofocus: true,
                          style: new TextStyle(
                            color: Colors.white,

                          ),
                          decoration: new InputDecoration(
                            //prefixIcon: new Icon(FontAwesomeIcons.search,color: Colors.white),
                            hintText: "Procurar...",
                            hintStyle: new TextStyle(color: Colors.white)
                          ),
                        );}
                        else {
                          listaDegetos = ListaDeConteudo.lista;
                          this.actionIcon = new Icon(FontAwesomeIcons.search);
                          this.appBarTitle = Text(bartitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
                        }


                      });
          } ,),]
      ),
      body: ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                  itemCount: listaDegetos.length,
                  itemBuilder: (BuildContext context, int index) {
                    Degeto degeto = listaDegetos[index];
                    return _createTile(context, degeto);
                  },
                ),
    );
  }
  
}