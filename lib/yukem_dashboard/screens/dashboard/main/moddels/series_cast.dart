import 'package:intl/intl.dart';

import '../../../../models/data_ojects/chart_data.dart';

class SeriesCast {
  static List<DataSeries> castRawSeries(Map<String, dynamic> rawSeries,
      ChartData<int> Function(List<dynamic>) getItem) {
    final List<DataSeries> castSeries = [];

    rawSeries.forEach((key, series) {
      final chartSeries = <ChartData<int>>[];
      for (int i = 0; i < series.length; i++) {
        final row = series[i];
        chartSeries.add(getItem(row));
      }

      castSeries.add(DataSeries(key, chartSeries));
    });

    return castSeries;
  }

  static List<DataSeries<DateTime>> castRawContas(List<dynamic> rawSeries) {
    final List<DataSeries<DateTime>> castSeries = [];

    final pago = <ChartData<DateTime>>[];
    final atraso = <ChartData<DateTime>>[];
    final vencendo = <ChartData<DateTime>>[];

    for (int i = 0; i < rawSeries.length; i++) {
      final row = rawSeries[i];
      final data = DateFormat('MM-dd').parse(row[0]);

      pago.add(ChartData(data, row[1].toDouble()));
      atraso.add(ChartData(data, row[2].toDouble()));
      vencendo.add(ChartData(data, row[3].toDouble()));
    }

    castSeries.add(DataSeries('Pago', pago));
    castSeries.add(DataSeries('Atraso', atraso));
    castSeries.add(DataSeries('Vencendo', vencendo));

    return castSeries;
  }
}
