import 'dart:math';

import '../data_ojects/chart_data.dart';

class SampleData {
  static List<ChartData<String>> RandomPie({int qtd = 4}) {
    final List<ChartData<String>> list = [];

    final rng = Random();

    for (int i = 0; i < qtd; i++) {
      list.add(ChartData('x[${i}]', rng.nextDouble()));
    }

    return list;
  }

  static DataSeries<int> RandomSeriesInt(String nome, {int days = 30}) {
    final List<ChartData<int>> list = [];

    final rng = Random();

    for (int i = 0; i < days; i++) {
      list.add(ChartData(i + 1, rng.nextDouble()));
    }

    return DataSeries<int>(nome, list);
  }

  static DataSeries<String> RandomSeriesStr(String nome, {int days = 30}) {
    final List<ChartData<String>> list = [];

    final rng = Random();

    for (int i = 0; i < days; i++) {
      list.add(ChartData('${i + 1}', rng.nextDouble()));
    }

    return DataSeries<String>(nome, list);
  }

  static DataSeries<DateTime> RandomSeriesDate(String nome, {int days = 30}) {
    final List<ChartData<DateTime>> list = [];

    final rng = Random();

    for (int i = 0; i < days; i++) {
      list.add(ChartData(DateTime(days = i + 1), rng.nextDouble()));
    }

    return DataSeries<DateTime>(nome, list);
  }
}
