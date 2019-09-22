import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Degeto{
  int id;
  String icone;
  String titulo;
  bool marcado;

  Degeto(this.id, this.icone, this.titulo, this.marcado);
}

class CategoriaDegeto{
  int id;
  String imagePath, titulo;
  List<Tipo> tipo;

  CategoriaDegeto(this.id, this.imagePath, this.titulo, this.tipo);
}

class Tipo{
  int id, categoria, qtd;
  String tipo, imagem;
  bool isCategoria, marcado;


  Tipo(this.id, this.tipo, this.marcado, this.qtd, {this.imagem, this.isCategoria});
}

class ListaDeCategorias{

  static List<Tipo> adicionados = new List();


  static List<Tipo> listPlastico = [
    Tipo(1, "Tampas", false, 0),
    Tipo(2, "Canudos", false, 0),
    Tipo(3, "Palitos de pirulito/picolé", false, 0),
    Tipo(4, "Cotonete", false, 0),
    Tipo(5, "Copos", false, 0),
    Tipo(6, "Talheres", false, 0),
    Tipo(7, "Garrafas de Água", false, 0),
    Tipo(8, "Garrafas PET", false, 0),
    Tipo(9, "Garrafas (outras)", false, 0),
    Tipo(10, "Folhas", false, 0),
    Tipo(11, "Sacolas", false, 0),
    Tipo(12, "Celofane", false, 0),
    Tipo(13, "Embalagens de alimento (saquinho de picolé, biscoito, pipoca etc.)", false, 0),
    Tipo(14, "Potes de alimento (margarina, iogurte, sorvete, etc.)", false, 0),
  ];

  static List<Tipo> listFragmentos = [
    Tipo(15, "Recipientes de casa", false, 0),
    Tipo(16, "Frascos diversos", false, 0),
    Tipo(17, "Anel garrafa", false, 0),
    Tipo(18, "Lacres diversos", false, 0),
    Tipo(19, "Óleo saquinho", false, 0),
    Tipo(20, "Água oxigenada", false, 0),
    Tipo(21, "Fralda", false, 0),
    Tipo(22, "Absorvente", false, 0),
    Tipo(23, "Remédios", false, 0),
    Tipo(24, "Seringa", false, 0),
    Tipo(25, "Pentes", false, 0),
    Tipo(26, "Chupeta", false, 0),
    Tipo(27, "Canetas", false, 0),
    Tipo(28, "Balão de sopro", false, 0),
    Tipo(29, "Brinquedos", false, 0),
    Tipo(30, "Velas", false, 0),
    Tipo(31, "Isopor", false, 0),
    Tipo(32, "Espuma", false, 0),
    Tipo(33, "Fio nylon", false, 0),
    Tipo(34, "Fita nylon", false, 0),
    Tipo(35, "Corda nylon", false, 0),
    Tipo(36, "Sapatos", false, 0),
    Tipo(37, "Sandália", false, 0),
  ];  


  static List<Tipo> listMadeira = [
    Tipo(38, "Palitos e espetos", false, 0),
    Tipo(39, "Colher de Sorvete", false, 0),
    Tipo(40, "Pedaços", false, 0),
    Tipo(41, "Troncos", false, 0),
  ];
  static List<Tipo> listVidro = [
    Tipo(42, "Lâmpada", false, 0),
    Tipo(43, "Fragmentos", false, 0),
    Tipo(44, "Garrafas", false, 0),
    Tipo(45, "Frascos de Remédio", false, 0),
  ];
  static List<Tipo> listAco = [
    Tipo(46, "Tampa refrigerante / cerveja", false, 0),
    Tipo(47, "Latas", false, 0),
    Tipo(48, "Fios", false, 0),
  ];
  static List<Tipo> listAluminio = [
    Tipo(49, "Latas", false, 0),
    Tipo(50, "Quentinhas", false, 0),
  ];
  static List<Tipo> listPapel = [
    Tipo(51, "Papel", false, 0),
    Tipo(52, "Papelão", false, 0),
    Tipo(53, "Sacos", false, 0),
    Tipo(54, "Pratos", false, 0),
    Tipo(55, "Carteira de cigarro", false, 0),
    Tipo(56, "Longa vida", false, 0),
    Tipo(57, "Tampa de quentinha", false, 0),
  ];
  static List<Tipo> listOrganico = [
    Tipo(58, "Animais mortos", false, 0),
    Tipo(59, "Restos de Comida", false, 0),
    Tipo(60, "Coco", false, 0),
  ];
  static List<Tipo> listTecido = [
    Tipo(61, "Tecidos", false, 0),
  ];

  static List<Tipo> listaGeral = [

    Tipo(1001, "PLÁSTICOS", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(1, "Tampas", false, 0),
    Tipo(2, "Canudos", false, 0),
    Tipo(3, "Palitos de pirulito/picolé", false, 0),
    Tipo(4, "Cotonete", false, 0),
    Tipo(5, "Copos", false, 0),
    Tipo(6, "Talheres", false, 0),
    Tipo(7, "Garrafas de Água", false, 0),
    Tipo(8, "Garrafas PET", false, 0),
    Tipo(9, "Garrafas (outras)", false, 0),
    Tipo(10, "Folhas", false, 0),
    Tipo(11, "Sacolas", false, 0),
    Tipo(12, "Celofane", false, 0),
    Tipo(13, "Embalagens de alimento (saquinho de picolé, biscoito, pipoca etc.)", false, 0),
    Tipo(14, "Potes de alimento (margarina, iogurte, sorvete, etc.)", false, 0),

    Tipo(1002, "FRAGMENTOS", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(15, "Recipientes de casa", false, 0),
    Tipo(16, "Frascos diversos", false, 0),
    Tipo(17, "Anel garrafa", false, 0),
    Tipo(18, "Lacres diversos", false, 0),
    Tipo(19, "Óleo saquinho", false, 0),
    Tipo(20, "Água oxigenada", false, 0),
    Tipo(21, "Fralda", false, 0),
    Tipo(22, "Absorvente", false, 0),
    Tipo(23, "Remédios", false, 0),
    Tipo(24, "Seringa", false, 0),
    Tipo(25, "Pentes", false, 0),
    Tipo(26, "Chupeta", false, 0),
    Tipo(27, "Canetas", false, 0),
    Tipo(28, "Balão de sopro", false, 0),
    Tipo(29, "Brinquedos", false, 0),
    Tipo(30, "Velas", false, 0),
    Tipo(31, "Isopor", false, 0),
    Tipo(32, "Espuma", false, 0),
    Tipo(33, "Fio nylon", false, 0),
    Tipo(34, "Fita nylon", false, 0),
    Tipo(35, "Corda nylon", false, 0),
    Tipo(36, "Sapatos", false, 0),
    Tipo(37, "Sandália", false, 0),

    Tipo(1003, "MADEIRA", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(38, "Palitos e espetos", false, 0),
    Tipo(39, "Colher de Sorvete", false, 0),
    Tipo(40, "Pedaços", false, 0),
    Tipo(41, "Troncos", false, 0),

    Tipo(1004, "VIDRO", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(42, "Lâmpada", false, 0),
    Tipo(43, "Fragmentos", false, 0),
    Tipo(44, "Garrafas", false, 0),
    Tipo(45, "Frascos de Remédio", false, 0),

    Tipo(1005, "AÇO", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(46, "Tampa refrigerante / cerveja", false, 0),
    Tipo(47, "Latas", false, 0),
    Tipo(48, "Fios", false, 0),
    
    Tipo(1006, "ALUMÍNIO", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(49, "Latas", false, 0),
    Tipo(50, "Quentinhas", false, 0),


    Tipo(1007, "PAPEL", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(51, "Papelão", false, 0),
    Tipo(52, "Sacos", false, 0),
    Tipo(53, "Pratos", false, 0),
    Tipo(54, "Carteira de cigarro", false, 0),
    Tipo(55, "Longa vida", false, 0),
    Tipo(56, "Tampa de quentinha", false, 0),

    Tipo(1008, "ORGÂNICOS", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(57, "Animais mortos", false, 0),
    Tipo(58, "Restos de Comida", false, 0),
    Tipo(59, "Coco", false, 0),

    Tipo(1002, "TECIDOS", false, 0, imagem: "assets/bottle.png", isCategoria: true),
    Tipo(59, "Tecidos", false, 0),
  ];

  static CategoriaDegeto pontaCigarro = new CategoriaDegeto(0, "assets/bottle.png",  "PONTAS DE CIGARRO", null);
  static CategoriaDegeto plasticos = new CategoriaDegeto(1, "assets/bottle.png",  "PLÁSTICO", null);
  static CategoriaDegeto fragmentos = new CategoriaDegeto(2, "assets/bottle.png",  "FRAGMENTOS", null);
  static CategoriaDegeto madeira = new CategoriaDegeto(3, "assets/bottle.png",  "MADEIRA", null);
  static CategoriaDegeto vidro = new CategoriaDegeto(4, "assets/bottle.png",  "VIDRO", null);
  static CategoriaDegeto aco = new CategoriaDegeto(5, "assets/bottle.png",  "AÇO", null);
  static CategoriaDegeto aluminio = new CategoriaDegeto(6, "assets/bottle.png",  "ALUMÍNIO", null);
  static CategoriaDegeto papel = new CategoriaDegeto(7, "assets/bottle.png",  "PAPEL", null);
  static CategoriaDegeto organico = new CategoriaDegeto(8, "assets/bottle.png",  "ORGÂNICOS", null);
  static CategoriaDegeto tecido = new CategoriaDegeto(9, "assets/bottle.png",  "TECIDOS", null);

  

  static List<CategoriaDegeto> listaCategorias = [
    pontaCigarro,
    plasticos,
    fragmentos,
    madeira,
    vidro,
    aco,
    aluminio,
    papel,
    organico,
    tecido
  ];

}



class Motivo{
  int id;
  String motivo;
  bool up, down, votou;

  Motivo(this.id, this.motivo, this.up, this.down, this.votou);
}

class ListaDeConteudo {

  static List<Degeto> lista = [
    new Degeto(0, "assets/bottle.png", "Garrafa", false),
    new Degeto(1, "assets/can.png", "Lata", false),
    new Degeto(2, "assets/tire.png", "Pneu", false),
    new Degeto(3, "assets/bag.png", "Sacola", false),
    ];

  static List<Motivo> listaMotivos = [
    new Motivo(0, "A imagem contem nudez?", false, false, false),
    new Motivo(1, "A imagem está no padrão?", false, false, false),
    new Motivo(2, "A imagem é na praia ou no mangue?", false, false, false),
    new Motivo(3, "Contêm resíduos sólidos ou esgoto?", false, false, false),
  ];

    static List<Degeto> listaDegetos = new List();


  

}