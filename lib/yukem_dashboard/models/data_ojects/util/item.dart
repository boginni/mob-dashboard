import 'dart:convert';

class Item {
  final int id;
  final String nome;

  bool selecionado = false;

  @override
  String toString() {
    return '($id) $nome';
  }

  static String toSelectionList(List<Item> itens) {
    final List<int> list = [];

    for (final item in itens) {
      if (item.selecionado) {
        list.add(item.id);
      }
    }

    return const JsonEncoder().convert(list);
  }

  static restoreSelectionList(String? encodedList, List<Item> itens) {
    if (encodedList == null) {
      return;
    }

    try {
      final List<dynamic> list = const JsonDecoder().convert(encodedList);
      for (final item in itens) {
        item.selecionado = list.contains(item.id);
      }
    } catch (e) {
      print(encodedList);
      print(e);
    }
  }

  static Map<String, int> getFilterList(List<Item> itens) {

    final Map<String, int> map = {};

    itens.forEach((element) {
      map[element.id.toString()] = element.selecionado? 1 : 0;
    });

    return map;

  }

  Item(this.id, this.nome);
}
