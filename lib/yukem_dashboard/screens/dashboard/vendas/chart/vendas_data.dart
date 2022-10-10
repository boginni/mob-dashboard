import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../moddels/chart_data.dart';

class ChartVendas extends StatefulWidget {
  const ChartVendas({Key? key, required this.dataSeries, this.interval = 1})
      : super(key: key);

  final List<DataSeries> dataSeries;
  final double? interval;

  @override
  State<ChartVendas> createState() => _ChartVendasState();
}

class _ChartVendasState extends State<ChartVendas> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true, animationDuration: 1, duration: 100);
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(locale: 'pt-br'),
      ),
      primaryXAxis: NumericAxis(
        interval: widget.interval,
        labelRotation: 45,
      ),
      tooltipBehavior: _tooltipBehavior,
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: <ChartSeries>[
        for (int i = 0; i < widget.dataSeries.length; i++)
          LineSeries<ChartData, int>(
            name: widget.dataSeries[i].title,
            dataSource: widget.dataSeries[i].series,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
      ],
    );
  }
}
