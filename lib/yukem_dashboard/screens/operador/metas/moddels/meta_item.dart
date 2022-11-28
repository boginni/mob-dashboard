import 'package:flutter/cupertino.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/connection/server_routes.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/produto.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';

class MetaItem {
  static Future<List<MetaItem>> getData(BuildContext context,
      {required int idMeta, required int idVendedor}) async {
    final app = AppConnection.of(context);

    final rows = await app.getBuffetResult(ServerRoutes.meta_item_list,
        body: {'id_meta': idMeta, 'id_vendedor': idVendedor}, headers: {});

    final List<MetaItem> metas = [];
    for (final item in rows) {
      metas.add(MetaItem.parse(item));
    }

    return metas;
  }

  final int id;
  int idProduto;
  String nomeProduto;
  int qtdMeta;
  final int qtdAtual;
  final double valorAtual;

  int? idMeta;
  int? idVendedor;

  final double qtdMetaDia;
  final double qtdTendencia;
  final double pctTendencia;

  MetaItem(
      this.id,
      this.idProduto,
      this.nomeProduto,
      this.qtdMeta,
      this.qtdAtual,
      this.valorAtual,
      this.qtdMetaDia,
      this.qtdTendencia,
      this.pctTendencia);

  factory MetaItem.parse(List<dynamic> item) {
    return MetaItem(item[2], item[3], item[4], item[5], item[6], item[7],
        item[9], item[10], item[11]);
  }

  factory MetaItem.add(int idMeta, int idVendedor) {
    final m = MetaItem(0, 0, 'Selecionar Produto', 0, 0, 0, 0, 0, 0);

    m.idMeta = idMeta;
    m.idVendedor = idVendedor;

    return m;
  }

  // factory MetaItem.add(List<dynamic> item) {
  //   return MetaItem(item[2], 0, 0, 0, 0, 0);
  // }

  double getLinearProgressValue() {
    if (qtdMeta == 0) return 0;

    double x = qtdAtual.toDouble() / qtdMeta.toDouble();

    if (x > 1) {
      x = 1;
    }

    return x;
  }

  Produto toProduto() {
    return Produto(idProduto, nomeProduto, true);
  }

  Future<void> salvar(BuildContext context) async {
    final app = AppConnection.of(context);

    if (id == 0) {
      final body = {
        "id_meta": idMeta,
        "id_vendedor": idVendedor,
        "id_produto": idProduto,
        "quantidade": qtdMeta
      };

      await app.serverPost(ServerRoutes.meta_item_add, body: body, headers: {});

      return;
    }

    final body = {
      "id_meta_item": id,
      "id_produto": idProduto,
      "quantidade": qtdMeta
    };

    await app.serverPost(ServerRoutes.meta_item_edit, body: body, headers: {});
  }

  Future<void> remove(BuildContext context) async {
    final app = AppConnection.of(context);
    await app.serverPost(ServerRoutes.meta_item_remove,
        body: {'id_meta_item': id}, headers: {});
  }
}
