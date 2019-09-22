import 'dart:io';
import 'package:camera/camera.dart';

class Usuario{
  static String id;
  static double lat;
  static double lon;
  static String cidade;
  static String estado;
  static int pontos;
  static int numeroPublicacao;
  static int pontosCorridos;
  
  static CameraDescription camera;
  static List<String> imagens;
  static String urlBase = "http://grabbex.com/marlimpo/";
  static bool testeProducao = false;
}