import 'chart_data.dart';

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

  static List<DataSeries> castRawContas(List<dynamic> rawSeries) {
    final List<DataSeries> castSeries = [];

    final pago = <ChartData<int>>[];
    final atraso = <ChartData<int>>[];
    final vencendo = <ChartData<int>>[];

    for (int i = 0; i < rawSeries.length; i++) {
      final row = rawSeries[i];
      final mes = row[0];
      pago.add(ChartData(mes, row[1]));
      atraso.add(ChartData(mes, row[2]));
      vencendo.add(ChartData(mes, row[3]));
    }

    castSeries.add(DataSeries('Pago', pago));
    castSeries.add(DataSeries('Atraso', atraso));
    castSeries.add(DataSeries('Vencendo', vencendo));

    return castSeries;
  }
}
