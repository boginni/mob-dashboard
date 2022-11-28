import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';
import '../../../../models/data_ojects/util/produto.dart';

class ABCProduto {
  static Future<List<ABCProduto>> getData(
    BuildContext context,
    String dataAno,
    String dataMes,
  ) async {
    final app = AppConnection.of(context);
    return await app.serverPost('/dash/web/main/abc/produto',
        body: {'data'}).then((response) {
      return castData(const JsonDecoder().convert(response.body));
    });
  }

  static List<ABCProduto> castData(dynamic value) {
    final List<ABCProduto> list = [];
    for (final item in value) {
      list.add(ABCProduto.parse(item));
    }

    return list;
  }

  ABCProduto(
    this.produto,
    this.qtdVendas,
    this.qtdComercial,
    this.valorProdutos,
    this.valorDescontos,
    this.valorTotal,
  );

  factory ABCProduto.parse(List<dynamic> row) {
    final produto = Produto(row[1], row[2], false);

    return ABCProduto(
      produto,
      row[3],
      row[4],
      row[5].toDouble(),
      row[6].toDouble(),
      row[7].toDouble(),
    );
  }

  final Produto produto;

  final int qtdVendas;
  final int qtdComercial;

  final double valorProdutos;
  final double valorDescontos;
  final double valorTotal;
}
