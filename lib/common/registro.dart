
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Registro {
  String id, idAutor, imagemAutor, nomeAutor, imagemPost, comentario;
  double latitude, longitude;
  bool sanado, verificando;
  int status, votosAFavor, votosContra;
  List<String> tipos;
  String dataStr;
  BitmapDescriptor icone;

  Registro({this.id, this.idAutor, this.imagemAutor, this.nomeAutor, this.imagemPost, this.dataStr, this.icone,
   this.comentario, this.latitude, this.longitude, this.sanado, this.status, this.votosAFavor,this.votosContra, this.tipos, this.verificando});


  static List<Registro> listaRegistros = new List();
  static List<Registro> listaRegistrosFeed = new List();
  static List<Registro> listaMeusRegistros = new List();

  
}