import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../component/chart_container.dart';
import '../moddels/abc_produto.dart';
import '../moddels/chart_data.dart';

class ChartABCProdutos extends StatefulWidget {
  const ChartABCProdutos(
      {Key? key, required this.dataSeries, this.interval = 1})
      : super(key: key);

  final List<ChartData<String>> dataSeries;
  final double? interval;

  @override
  State<ChartABCProdutos> createState() => _ChartABCProdutosState();
}

class _ChartABCProdutosState extends State<ChartABCProdutos> {
  // late TooltipBehavior _tooltipBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints);
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(locale: 'pt-br'),
      ),
      primaryXAxis: CategoryAxis(
        arrangeByIndex: true,
        isVisible: false,
      ),
      // tooltipBehavior: _tooltipBehavior,
      trackballBehavior: _trackballBehavior,
      series: <ChartSeries>[
        ColumnSeries<ChartData, String>(
          // name: widget.dataSeries.title,
          dataSource: widget.dataSeries,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
      ],
    );
  }
}

class SampleABCProdutos extends StatefulWidget {
  const SampleABCProdutos({
    Key? key,
    required this.dataAno,
    required this.dataMes,
  }) : super(key: key);

  final String dataAno;
  final String dataMes;

  @override
  State<SampleABCProdutos> createState() => _SampleABCProdutosState();
}

class _SampleABCProdutosState extends State<SampleABCProdutos> {
  bool onLoading = true;

  List<ChartData<String>> series = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ABCProduto.getData(context, widget.dataAno, widget.dataMes).then((value) {
        final list = <ChartData<String>>[];

        add(ChartData<String> data) {
          list.add(data);
        }

        value.forEach((element) {
          add(ChartData<String>(element.produto.nome, element.valorTotal));
        });

        setState(() {
          series = list;
          onLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChartContainer(
      title: ChartContainerTitle('ABC Produtos'),
      child: ChartABCProdutos(dataSeries: series),
    );
  }
}
