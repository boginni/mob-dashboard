class Item {
  final int id;
  final String nome;


  @override
  String toString() {
    return '($id) $nome';
  }

  Item(this.id, this.nome);
}
