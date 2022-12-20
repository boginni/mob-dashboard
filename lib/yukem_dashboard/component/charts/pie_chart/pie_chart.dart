import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/data_ojects/chart_data.dart';

class PieChart extends StatelessWidget {
  const PieChart(
      {Key? key, required this.dataSeries, this.tooltipBehavior})
      : super(key: key);

  final List<ChartData<String>> dataSeries;
  final TooltipBehavior? tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      // tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<ChartData<String>, String>(
          dataSource: dataSeries,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelMapper: (ChartData data, _) =>
              NumberFormat.simpleCurrency(locale: 'pt-br').format(data.y),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
          ),
        ),
      ],
    );
  }
}
