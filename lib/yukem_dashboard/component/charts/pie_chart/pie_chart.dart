import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/data_ojects/chart_data.dart';

class PieChart extends StatelessWidget {
  const PieChart(
      {Key? key,
      required this.dataSeries,
      this.tooltipBehavior,
      this.outerLegend = true})
      : super(key: key);

  final List<ChartData> dataSeries;
  final TooltipBehavior? tooltipBehavior;
  final bool outerLegend;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap),
      // tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: dataSeries,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelMapper: (ChartData data, _) =>
              NumberFormat.simpleCurrency(locale: 'pt-br').format(data.y),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            // Avoid labels intersection
            labelIntersectAction: LabelIntersectAction.shift,
            labelPosition: outerLegend ? ChartDataLabelPosition.outside : ChartDataLabelPosition.inside,
            connectorLineSettings: const ConnectorLineSettings(
              type: ConnectorType.curve,
              length: '25%',
            ),
            overflowMode: OverflowMode.shift,
          ),
        ),
      ],
    );
  }
}
