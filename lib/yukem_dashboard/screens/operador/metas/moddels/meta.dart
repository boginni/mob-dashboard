import 'package:flutter/cupertino.dart';
import 'package:yukem_dashboard/sdk/common/formatter/date_time_formatter.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/connection/server_routes.dart';

import '../../../../../sdk/models/configuracao/app_connection.dart';

class Meta {
  late int diasTotais;

  final int id;
  String nome;
  int diasUteis;

  int diasDecorridos;
  int diasRestantes;

  DateTime dataInicio;
  DateTime dataFim;
  int status;
  int oculto;
  int qtdVendedores;

  Meta(
      this.id,
      this.nome,
      this.diasUteis,
      this.diasDecorridos,
      this.diasRestantes,
      this.dataInicio,
      this.dataFim,
      this.status,
      this.oculto,
      this.qtdVendedores) {
    calcularDiasTotais();
  }

  factory Meta.add() {
    return Meta(
      0,
      'Nova Tabela De metas',
      1,
      1,
      0,
      DateTime.now(),
      DateTime.now(),
      0,
      0,
      0,
    );
  }

  factory Meta.parse(List<dynamic> res) {
    return Meta(
      res[0],
      res[1],
      res[2],
      res[3],
      res[4],
      DateTime.parse(res[5]),
      DateTime.parse(res[6]),
      res[7],
      res[8],
      res[9],
    );
  }

  calcularDiasTotais() {
    diasTotais = dataFim.difference(dataInicio).inDays;
  }

  static Future<List<Meta>> getData(BuildContext context) async {
    final app = AppConnection.of(context);

    final rows = await app
        .getBuffetResult(ServerRoutes.meta_header_list, body: {}, headers: {});

    final List<Meta> metas = [];

    for (final item in rows) {
      metas.add(Meta.parse(item));
    }

    return metas;
  }

  Future<dynamic> salvar(BuildContext context) async {
    final app = AppConnection.of(context);

    diasRestantes = diasUteis - diasDecorridos;
    await app.serverPost(
        status == 1
            ? ServerRoutes.meta_header_edit
            : ServerRoutes.meta_header_add,
        body: toMaps(),
        headers: {});
  }

  Future<dynamic> remover(BuildContext context) async {
    final app = AppConnection.of(context);
    await app.serverPost(ServerRoutes.meta_header_remove,
        body: toMaps(), headers: {});
  }

  double getCircularProgessValue() {
    return diasDecorridos / (diasUteis == 0 ? 1 : diasUteis);
  }

  Map<String, dynamic> toMaps() {
    return {
      "id_meta": id,
      "apelido": nome,
      "diasUteis": diasUteis,
      "diasDecorridos": diasDecorridos,
      "diasRestantes": diasRestantes,
      "dataInicio": DateFormatter.databaseDate.format(dataInicio),
      "dataFim": DateFormatter.databaseDate.format(dataFim)
    };
  }

  Future<dynamic> copy(BuildContext context, Meta other) async {
    final app = AppConnection.of(context);
    await app.serverPost(ServerRoutes.meta_header_copy,
        body: {'id_meta_copy': other.id, 'id_meta_paste': id}, headers: {});
  }
}
