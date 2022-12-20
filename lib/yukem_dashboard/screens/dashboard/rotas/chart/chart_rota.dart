import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../sdk/models/configuracao/app_theme.dart';
import '../../../../component/chart_container.dart';
import '../../../../component/container_loading.dart';
import '../../../../models/data_ojects/chart_data.dart';
import '../../../../models/data_ojects/util/item.dart';
import '../moddels/cidade_list_item.dart';
import '../moddels/rota_item_list.dart';

class ChartRotas extends StatefulWidget {
  const ChartRotas({Key? key, required this.rotaItemList}) : super(key: key);

  final List<RotaItemList> rotaItemList;

  @override
  State<ChartRotas> createState() => _ChartRotasState();
}

class _ChartRotasState extends State<ChartRotas> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      hideDelay: 1500,
      lineWidth: 1,
      builder: (context, trackballDetails) {
        return ChartRotaCidade(
          item: widget.rotaItemList[trackballDetails.pointIndex!].rota,
        );
      },
    );

    _controller = ScrollController();
  }

  late final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    final money = NumberFormat.simpleCurrency(locale: 'pt_br');

    return SingleChildScrollView(
      controller: _controller,
      child: SizedBox(
        height: 500 + (25.0 * widget.rotaItemList.length),
        width: 600,
        child: SfCartesianChart(
          trackballBehavior: _trackballBehavior,
          primaryXAxis: CategoryAxis(
              interval: 1,
              labelsExtent: 150,
              labelPosition: ChartDataLabelPosition.inside,
              opposedPosition: true),
          primaryYAxis: NumericAxis(numberFormat: money),
          series: <ChartSeries>[
            // Renders bar chart
            BarSeries<RotaItemList, String>(
              dataSource: widget.rotaItemList,
              xValueMapper: (data, _) => data.rota.toString(),
              yValueMapper: (data, _) => data.valorTotal,
              dataLabelMapper: (RotaItemList data, _) =>
                  money.format(data.valorTotal),
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.bottom,
                  textStyle: AppTheme.of(context).textTheme.body(fontSize: 10)),
            )
          ],
        ),
      ),
    );
  }
}

class ChartRotaCidade extends StatefulWidget {
  const ChartRotaCidade({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<ChartRotaCidade> createState() => _ChartRotaCidadeState();
}

class _ChartRotaCidadeState extends State<ChartRotaCidade> {
  @override
  void initState() {
    super.initState();
    lastRota = widget.item;
    getChartData();
  }

  List<ChartData<String>> dataSeries = [];
  late bool onLoadingChart = true;

  Timer? t;

  getChartData() async {
    cancel();
    onLoadingChart = true;
    t = Timer(
      const Duration(milliseconds: 250),
      () {
        RotaCidadeItemList.getData(context, widget.item.id).then((value) {
          setState(() {
            dataSeries = [];
            for (final item in value) {
              dataSeries.add(ChartData(item.cidade.nome, item.valorTotal));
            }
            onLoadingChart = false;
          });
        });
      },
    );
  }

  cancel() {
    if (t != null && t!.isActive) {
      t!.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  late Item lastRota;

  @override
  Widget build(BuildContext context) {
    final child = onLoadingChart
        ? ContainerLoading()
        : Column(
            children: [
              ChartContainer(
                title: ChartContainerTitle(widget.item.toString()),
                child: SfCircularChart(
                  // legend: Legend(isVisible: true, position: LegendPosition.bottom),
                  // tooltipBehavior: tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<ChartData<String>, String>(
                      animationDuration: 250,
                      dataSource: dataSeries,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelMapper: (ChartData data, _) {
                        final valor =
                            NumberFormat.simpleCurrency(locale: 'pt-br')
                                .format(data.y);
                        final cid = data.x;

                        return '$cid\n$valor';
                      },
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                        useSeriesColor: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

    return SizedBox(
      width: 400,
      height: 400,
      child: child,
    );
  }

  @override
  void didUpdateWidget(dynamic oldWidget) {
    if (lastRota != widget.item) {
      getChartData();
    }
    lastRota = widget.item;
    super.didUpdateWidget(oldWidget);
  }
}
