import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';
import '../../../../models/data_ojects/util/pessoa.dart';

class ABCCliente {
  static Future<List<ABCCliente>> getData(BuildContext context) async {
    final app = AppConnection.of(context);
    return await app.serverPost(
      '/dash/web/main/abc/cliente',
      body: {},
      headers: {},
    ).then((response) {
      final value = const JsonDecoder().convert(response.body);

      final List<ABCCliente> list = [];
      for (final item in value) {
        list.add(ABCCliente.parse(item));
      }

      return list;
    });
  }

  ABCCliente(
    this.pessoa,
    this.qtdVendas,
    this.valorProdutos,
    this.valorDescontos,
    this.valorTotal,
  );

  factory ABCCliente.parse(List<dynamic> row) {
    final produto = Pessoa(row[1], row[2]);

    return ABCCliente(
      produto,
      row[3],
      row[4].toDouble(),
      row[5].toDouble(),
      row[6].toDouble(),
    );
  }

  final Pessoa pessoa;

  final int qtdVendas;

  final double valorProdutos;
  final double valorDescontos;
  final double valorTotal;


  /*

id_empresa dm_pk,
id_pessoa dm_pk,
nome_pessoa dm_nome,
qtd_vendas dm_qtd,
valor_produtos dm_moeda,
valor_desconto dm_moeda,
valor_total dm_moeda

   */
}
