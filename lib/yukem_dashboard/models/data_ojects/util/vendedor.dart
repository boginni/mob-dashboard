import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_user.dart';
import '../../../../sdk/models/configuracao/app_connection.dart';
import '../../connection/server_routes.dart';
import 'item.dart';

class Vendedor extends Item {
  final int id;
  String nome;
  String apelido;

  Vendedor(this.id, this.nome, this.apelido) : super(id, nome);

  factory Vendedor.utilList(List<dynamic> item) {
    final n = item[1] ?? '';
    final v = Vendedor(item[0], n, n);
    v.selecionado = item[2] == 1;
    return v;
  }

  static Future<List<Vendedor>> getDataFilter(
    BuildContext context, {
    int idTela = 1,
  }) async {
    final appConnection = AppConnection.of(context);
    final appUser = AppUser.of(context);
    final body = {"id_user": appUser.userID, 'id_tela': idTela};

    final rows = await appConnection.getResult(ServerRoutes.util_vendedor_list,
        body: body);

    final List<Vendedor> itens = [];

    for (final item in rows) {
      itens.add(Vendedor.utilList(item));
    }

    return itens;
  }

  static Future updateFilter(BuildContext context,
      {int idTela = 1, required List<Item> vendedores}) async {
    final appConnection = AppConnection.of(context);
    final appUser = AppUser.of(context);

    final body = {
      "id_user": appUser.userID,
      'id_tela': idTela,
      'vendedores': Item.getFilterList(vendedores)
    };

    await appConnection.serverPost(ServerRoutes.util_vendedor_set, body: body);
  }
}
