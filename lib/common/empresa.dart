class Empresa {
  int id, beneficios;
  String nome, foto;
  String validade;

  Empresa({this.id, this.nome, this.foto, this.beneficios, this.validade});

  static List<Empresa> listaEmpresasBeneficios = new List();
}