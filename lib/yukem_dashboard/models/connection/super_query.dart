import 'package:flutter/cupertino.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_connection.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_user.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/chart_data.dart';

class SuperQuery {
  static Future<Map<String, DataSeries>> simpleData(
    BuildContext context,
    String route, {
    int idTela = 1,
    required DateTime dataIni,
    required DateTime dataFim,
  }) async {
    final appConnection = AppConnection.of(context);
    final appUser = AppUser.of(context);
    final body = {
      "id_user": appUser.userID,
      'id_tela': idTela,
      'data_ini': '2022-09-01',
      'data_fim': '2022-09-30'
    };
    final rows = await appConnection.getResult(route, body: body);

    final Map<String, DataSeries> map = {};

    for (final queryName in rows.keys) {
      final query = rows[queryName];

      final List<ChartData> series = [];

      for (final item in query) {
        series.add(ChartData<String>(item[0], item[1]));
      }

      map[queryName] = DataSeries(queryName, List.from(series.reversed));
    }

    return map;
  }
}
