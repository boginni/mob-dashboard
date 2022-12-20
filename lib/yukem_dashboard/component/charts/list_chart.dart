import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

import '../chart_container.dart';
import '../../models/data_ojects/chart_data.dart';

class ChartItem {
  const ChartItem({
    required this.icon,
    required this.nome,
    required this.chart,
  });

  final IconData icon;
  final String nome;
  final Widget chart;
}

class ListCharts extends StatefulWidget {
  //--
  const ListCharts({
    Key? key,
    required this.charts,
    this.interval = 1,
    required this.title,
    this.width,
    this.height,
    this.expanded = false,
  }) : super(key: key);

  final List<ChartItem> charts;
  final double? interval;
  final String title;
  final double? width;
  final double? height;
  final bool expanded;

  @override
  State<ListCharts> createState() => _ListChartsState();
}

class _ListChartsState extends State<ListCharts> {

  @override
  void initState() {
    super.initState();

  }

  void next() {
    setState(() {
      curChart++;
      if (curChart >= widget.charts.length) {
        curChart = 0;
      }
    });
  }

  int curChart = 0;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);


    if (widget.charts.length == 0)
      return Container();

    final title = Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              child: InkWell(
                onTap: next,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.charts[curChart].icon,
                      color: theme.colorTheme.primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.charts[curChart].nome,
                      style: theme.textTheme.title3(),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              child: Text(
                widget.title,
                style:
                    theme.textTheme.title(color: theme.colorTheme.primaryColor),
              ),
              alignment: const Alignment(0, 0),
            ),
          ],
        ),
      ),
    );

    return ChartContainer(
        width: widget.width,
        height: widget.height,
        title: title,
        expanded: widget.expanded,
        child: widget.charts[curChart].chart);
  }
}

class CartesianChart extends StatelessWidget {
  const CartesianChart({
    Key? key,
    required this.dataSeries,
    this.interval,
    this.tooltipBehavior,
    this.trackballBehavior,
    required this.formatador,
  }) : super(key: key);

  final List<DataSeries<int>> dataSeries;
  final double? interval;
  final TooltipBehavior? tooltipBehavior;
  final TrackballBehavior? trackballBehavior;

  final String formatador;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(locale: 'pt-br'),
      ),
      // primaryXAxis: NumericAxis(),
      primaryXAxis: CategoryAxis(),
      // tooltipBehavior: tooltipBehavior,
      trackballBehavior: trackballBehavior,
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: <ChartSeries>[
        for (int i = 0; i < dataSeries.length; i++)
          StackedColumnSeries<ChartData<int>, String>(
            dataSource: dataSeries[i].series,
            xValueMapper: (ChartData<int> data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y,
            legendItemText: dataSeries[i].title,
            emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.zero),
          ),
      ],
    );
    ;
  }
}

class _CircularChart extends StatelessWidget {
  const _CircularChart({
    Key? key,
    required this.dataSeries,
    this.tooltipBehavior,
  }) : super(key: key);

  final List<DataSeries> dataSeries;
  final TooltipBehavior? tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    final series = <ChartData<String>>[];

    dataSeries.forEach((element) {
      series.add(element.sumSeries());
    });

    return SfCircularChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<ChartData<String>, String>(
          dataSource: series,
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
