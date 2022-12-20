import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/chart_data.dart';

import '../../../../../sdk/models/configuracao/app_theme.dart';

class ChartBarRows extends StatefulWidget {
  const ChartBarRows({Key? key, required this.dataSeries}) : super(key: key);

  final DataSeries dataSeries;

  @override
  State<ChartBarRows> createState() => _ChartBarRowsState();
}

class _ChartBarRowsState extends State<ChartBarRows> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      hideDelay: 1500,
      lineWidth: 1,
      // builder: (context, trackballDetails) {
      //   return ChartRotaCidade(
      //     item: widget.rotaItemList[trackballDetails.pointIndex!].rota,
      //   );
      // },
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
        height: 500 + (25.0 * widget.dataSeries.series.length),
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
            BarSeries<ChartData, dynamic>(
              dataSource: widget.dataSeries.series,
              xValueMapper: (data, _) => data.x.toString(),
              yValueMapper: (data, _) => data.y,
              dataLabelMapper: (ChartData data, _) => money.format(data.y),
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.bottom,
                textStyle: AppTheme.of(context).textTheme.body(fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
