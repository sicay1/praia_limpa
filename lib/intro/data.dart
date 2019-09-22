import 'package:flutter/material.dart';

var pageList = [
  PageModel(
      numero: "1",
      numeroStr: "PRIMEIRO PASSO",
      imagemInicial: "assets/camera.png",
      descImagemInicial: "Tire uma foto",
      imagemFinal: "assets/passo1.png",
      instrucao1: "Com o aplicativo marlimpo aberto, faça um registro com a câmera do seu celular.",
      instrucao2: "É importante que o celular esteja na horizontal e a foto seja tirada de cima. Assim é possível reconhecer os tipos de materiais que foram abandonados",),
  PageModel(
      numero: "2",
      numeroStr: "SEGUNDO PASSO",
      imagemInicial: "assets/lista.png",
      descImagemInicial: "Cadastre seu registro",
      imagemFinal: "assets/passo2.png",
      instrucao1: "Com o aplicativo marlimpo aberto, faça um registro com a câmera do seu celular.",
      instrucao2: "É importante que o celular esteja na horizontal e a foto seja tirada de cima. Assim é possível reconhecer os tipos de materiais que foram abandonados",),
  PageModel(
      numero: "3",
      numeroStr: "TERCEIRO PASSO",
      imagemInicial: "assets/compartilhar.png",
      descImagemInicial: "Compartilhe seu registro",
      imagemFinal: "assets/passo3.png",
      instrucao1: "Com o aplicativo marlimpo aberto, faça um registro com a câmera do seu celular.",
      instrucao2: "É importante que o celular esteja na horizontal e a foto seja tirada de cima. Assim é possível reconhecer os tipos de materiais que foram abandonados",),
];

List<List<Color>> gradients = [
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFFE2859F), Color(0xFFFCCF31)],
  [Color(0xFF5EFCE8), Color(0xFF736EFE)],
];

class PageModel {
  String numero, numeroStr, imagemInicial, descImagemInicial, imagemFinal, instrucao1, instrucao2;

  PageModel({this.numero, this.numeroStr, this.imagemInicial, this.descImagemInicial, this.imagemFinal, this.instrucao1, this.instrucao2});
}
