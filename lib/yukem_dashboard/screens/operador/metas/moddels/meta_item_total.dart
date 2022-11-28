import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/connection/server_routes.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';

class MetaItemTotal {
  static Future<List<MetaItemTotal>> getData(BuildContext context,
      {required int idMeta}) async {
    final app = AppConnection.of(context);

    final rows = await app.getBuffetResult(ServerRoutes.meta_total_list,
        body: {'id_meta': idMeta}, headers: {});

    final List<MetaItemTotal> metas = [];
    for (final item in rows) {
      metas.add(MetaItemTotal.parse(item));
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

  MetaItemTotal(this.idMeta, this.idProduto, this.nomeProduto, this.qtdMeta,
      this.qtdAtual, this.valorAtual, this.qtdDif, this.qtdMetaDia, this.qtdTendencia, this.pctTendencia);

  factory MetaItemTotal.parse(List<dynamic> item) {
    return MetaItemTotal(item[0], item[1], item[2], item[3], item[4], item[5], item[6], item[7], item[8], item[9],);
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
