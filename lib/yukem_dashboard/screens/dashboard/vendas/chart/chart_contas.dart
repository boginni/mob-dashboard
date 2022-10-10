import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

import '../../../../component/chart_container.dart';
import '../moddels/chart_data.dart';

class ChartContas extends StatefulWidget {
  const ChartContas(
      {Key? key,
      required this.dataSeries,
      this.interval = 1,
      required this.title})
      : super(key: key);

  final List<DataSeries> dataSeries;
  final double? interval;

  final String title;

  @override
  State<ChartContas> createState() => _ChartContasState();
}

class _ChartContasState extends State<ChartContas> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      animationDuration: 1,
      duration: 100,
    );
  }

  bool linear = false;

  int? onlyAt;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    final title = Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    linear = !linear;
                    onlyAt = null;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      linear ? Icons.area_chart : Icons.pie_chart,
                      color: theme.colorTheme.primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      linear ? 'Por Mês' : 'Total Anual',
                      style: theme.textTheme.title3(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: Text(
              widget.title,
              style:
                  theme.textTheme.title(color: theme.colorTheme.primaryColor),
            ),
            alignment: Alignment(0, 0),
          ),
          if(!linear)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (onlyAt == null) {
                      linear = false;
                      onlyAt = 8;
                    } else {
                      linear = false;
                      onlyAt = null;
                    }
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      linear ? Icons.area_chart : Icons.pie_chart,
                      color: theme.colorTheme.primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      onlyAt == null ? 'Total do Ano' : 'Mês Atual',
                      style: theme.textTheme.title3(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return ChartContainer(
      width: 616,
      height: 371,
      title: title,
      child: Row(
        children: [
          linear
              ? CartesianChart(
                  dataSeries: widget.dataSeries,
                  tooltipBehavior: _tooltipBehavior,
                )
              : CircularChart(
                  onlyAt: onlyAt,
                  dataSeries: widget.dataSeries,
                  tooltipBehavior: _tooltipBehavior,
                ),
          CircularChart(
            onlyAt: onlyAt,
            dataSeries: widget.dataSeries,
            tooltipBehavior: _tooltipBehavior,
          )
        ],
      ),
    );
  }
}

class CartesianChart extends StatelessWidget {
  const CartesianChart(
      {Key? key, required this.dataSeries, this.interval, this.tooltipBehavior})
      : super(key: key);

  final List<DataSeries> dataSeries;
  final double? interval;
  final TooltipBehavior? tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(locale: 'pt-br'),
      ),
      primaryXAxis: NumericAxis(
          // interval: interval,
          // labelRotation: 45,
          ),
      tooltipBehavior: tooltipBehavior,
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: <ChartSeries>[
        for (int i = 0; i < dataSeries.length; i++)
          // StackedAreaSeries<ChartData, int>(
          //   gradient: dataSeries[i].gradient,
          //   dataSource: dataSeries[i].series,
          //   xValueMapper: (ChartData data, _) => data.x,
          //   yValueMapper: (ChartData data, _) => data.y,
          //   legendItemText: dataSeries[i].title,
          //   emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.zero),
          // )
          StackedColumnSeries<ChartData, int>(
            dataSource: dataSeries[i].series,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            legendItemText: dataSeries[i].title,
            emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.zero),
          ),
      ],
    );
    ;
  }
}

class CircularChart extends StatelessWidget {
  const CircularChart(
      {Key? key, required this.dataSeries, this.tooltipBehavior, this.onlyAt})
      : super(key: key);

  final List<DataSeries> dataSeries;
  final TooltipBehavior? tooltipBehavior;

  final int? onlyAt;

  @override
  Widget build(BuildContext context) {
    final series = <ChartData<String>>[];
    dataSeries.forEach((element) {
      late final ChartData<String> item;
      if (onlyAt == null) {
        item = element.sumSeries();
      } else {
        item = ChartData(element.title, element.series[onlyAt!].y);
      }
      series.add(item);
    });

    return SfCircularChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      // tooltipBehavior: tooltipBehavior,
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
