import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';
import '../../../../models/data_ojects/util/item.dart';

class RotaCidadeItemList {
  static Future<List<RotaCidadeItemList>> getData(BuildContext context, int idRota) async {
    final app = AppConnection.of(context);
    return await app.serverPost(
      '/dash/web/main/pie/rotaCidade',
      body: {
        "idRota" : idRota
      },
      headers: {},
    ).then((response) {
      final value = const JsonDecoder().convert(response.body);
      final List<RotaCidadeItemList> list = [];
      for (final item in value) {
        list.add(RotaCidadeItemList.parse(item));
      }
      return list;
    });
  }

  RotaCidadeItemList(
    this.cidade,
    this.valorProdutos,
    this.valorDescontos,
    this.valorTotal,
  );

  factory RotaCidadeItemList.parse(List<dynamic> row) {
    final item = Item(row[2], row[3]);

    return RotaCidadeItemList(
      item,
      row[4].toDouble(),
      row[5].toDouble(),
      row[6].toDouble(),
    );
  }

  final Item cidade;

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
