import 'package:flutter/cupertino.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/connection/server_routes.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';

class MetaVendedor {
  final int id;
  final String nomeProduto;
  final int qtdMetas;

  MetaVendedor(this.id, this.nomeProduto, this.qtdMetas);

  factory MetaVendedor.parse(List<dynamic> item) {
    return MetaVendedor(item[1], item[2], item[3]);
  }

  static Future<List<MetaVendedor>> getData(BuildContext context,
      {required int idMeta}) async {
    // await Future.delayed(const Duration(milliseconds: 200));

    final app = AppConnection.of(context);

    final rows = await app.getBuffetResult(
        ServerRoutes.meta_vendedor_list,
        body: {'id_meta': idMeta},
        headers: {});

    final List<MetaVendedor> metas = [];
    for (final item in rows) {
      metas.add(MetaVendedor.parse(item));
    }

    return metas;
  }
}
