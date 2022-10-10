import 'package:flutter/material.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';

class MetaItemVendedor {
  static Future<List<MetaItemVendedor>> getData(BuildContext context,
      {required int idMeta, required int idProduto}) async {
    final app = AppConnection.of(context);

    final rows = await app.getBuffetResult('/dash/web/meta/total/vendedor',
        body: {'id_meta': idMeta, "id_produto": idProduto}, headers: {});

    final List<MetaItemVendedor> metas = [];
    for (final item in rows) {
      metas.add(MetaItemVendedor.parse(item));
    }

    return metas;
  }

  final int idMeta;
  final int idProduto;
  final String nomeProduto;
  final int qtdMeta;
  final int qtdAtual;
  final double valorAtual;

  final double qtdDif;
  final double qtdMetaDia;
  final double qtdTendencia;
  final double pctTendencia;

  MetaItemVendedor(
    this.idMeta,
    this.idProduto,
    this.nomeProduto,
    this.qtdMeta,
    this.qtdAtual,
    this.valorAtual,
    this.qtdDif,
    this.qtdMetaDia,
    this.qtdTendencia,
    this.pctTendencia,
  );

  factory MetaItemVendedor.parse(List<dynamic> item) {
    return MetaItemVendedor(item[0], item[1], item[3], item[5], item[6],
        item[7], item[8], item[9], item[10], item[11]);
  }

  double getLinearProgressValue() {
    if (qtdMeta == 0) return 0;

    double x = qtdAtual.toDouble() / qtdMeta.toDouble();

    if (x > 1) {
      x = 1;
    }

    return x;
  }
}
