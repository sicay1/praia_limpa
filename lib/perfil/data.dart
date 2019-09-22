class Animal{
  String nome, imagem;
  Animal(this.nome, this.imagem);
}

class Conteudo{
  static List<Animal> lista = [
      new Animal("Cavalo Marinho", "assets/001-fish.png"),
      new Animal("Cavalo Marinho", "assets/002-shrimp.png"),
      new Animal("Cavalo Marinho", "assets/003-kraken.png"),
      new Animal("Cavalo Marinho", "assets/004-fish-1.png"),
      new Animal("Cavalo Marinho", "assets/005-sea.png"),
      new Animal("Cavalo Marinho", "assets/006-ocean.png"),
    ];
}