import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';
import '../../../../models/data_ojects/util/item.dart';
import '../../../../models/data_ojects/util/pessoa.dart';

class RotaItemList {
  static Future<List<RotaItemList>> getData(BuildContext context) async {
    final app = AppConnection.of(context);
    return await app.serverPost(
      '/dash/web/main/pie/rota',
      body: {},
      headers: {},
    ).then((response) {
      final value = const JsonDecoder().convert(response.body);

      final List<RotaItemList> list = [];
      for (final item in value) {
        list.add(RotaItemList.parse(item));
      }

      return list;
    });
  }

  RotaItemList(
    this.rota,
    this.valorProdutos,
    this.valorDescontos,
    this.valorTotal,
  );

  factory RotaItemList.parse(List<dynamic> row) {
    final item = Item(row[1], row[2]);

    // print(row);

    return RotaItemList(
      item,
      row[3].toDouble(),
      row[4].toDouble(),
      row[5].toDouble(),
    );
  }

  final Item rota;

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
