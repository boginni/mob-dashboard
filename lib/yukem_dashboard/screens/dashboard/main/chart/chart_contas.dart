import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

import '../../../../component/chart_container.dart';
import '../../../../models/data_ojects/chart_data.dart';

class ChartContas extends StatefulWidget {
  //--
  const ChartContas({
    Key? key,
    required this.seriesAno,
    required this.seriesMes,
    this.interval = 1,
    required this.title,
    this.width,
    this.height,
  }) : super(key: key);

  final List<DataSeries<DateTime>> seriesAno;
  final List<DataSeries<DateTime>> seriesMes;
  final double? interval;

  final String title;

  final double? width;
  final double? height;

  @override
  State<ChartContas> createState() => _ChartContasState();
}

class _ChartContasState extends State<ChartContas> {
  late TooltipBehavior _tooltipBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      animationDuration: 1,
      duration: 100,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
  }

  bool cartesiano = false;
  bool filtroAno = false;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);

    final title = Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              child: InkWell(
                onTap: () {
                  setState(() {
                    cartesiano = !cartesiano;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      cartesiano ? Icons.area_chart : Icons.pie_chart,
                      color: theme.colorTheme.primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      cartesiano ? 'Cartesiano' : 'Torta',
                      style: theme.textTheme.title3(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    filtroAno = !filtroAno;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      filtroAno
                          ? Icons.calendar_view_month
                          : Icons.calendar_month,
                      color: theme.colorTheme.primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      filtroAno ? 'Total do Ano' : 'Mês Atual',
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

    final series = filtroAno ? widget.seriesAno : widget.seriesMes;

    return ChartContainer(
      width: widget.width,
      height: widget.height,
      title: title,
      child: Row(
        children: [
          Expanded(
            child: cartesiano
                ? CartesianChart(
                    dataSeries: series,
                    tooltipBehavior: _tooltipBehavior,
                    trackballBehavior: _trackballBehavior,
                    formatador: filtroAno ? 'MMMM' : 'dd/MM',
                  )
                : _CircularChart(
                    dataSeries: series,
                    tooltipBehavior: _tooltipBehavior,
                  ),
          ),
        ],
      ),
    );
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

  final List<DataSeries<DateTime>> dataSeries;
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
          StackedColumnSeries<ChartData<DateTime>, String>(
            dataSource: dataSeries[i].series,
            xValueMapper: (ChartData<DateTime> data, _) =>
                DateFormat(formatador).format(data.x),
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
