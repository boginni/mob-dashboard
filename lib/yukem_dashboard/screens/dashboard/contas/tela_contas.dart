import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/rotas/moddels/cidade_list_item.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/rotas/moddels/rota_item_list.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/vendas/moddels/chart_data.dart';

import '../../../../sdk/models/configuracao/app_theme.dart';
import '../../../component/drawer/custom_scaffold.dart';
import '../../../models/data_ojects/util/item.dart';

class TelaContas extends StatefulWidget {
  const TelaContas({Key? key}) : super(key: key);

  @override
  State<TelaContas> createState() => _TelaContasState();
}

class _TelaContasState extends State<TelaContas> {
  late bool onLoading = true;
  late bool onLoadingChart = true;
  final _controller = ScrollController();
  List<RotaItemList> rotaItemList = [];
  List<ChartData<String>> chartData = [];

  Item? curRota;

  getData() async {
    await RotaItemList.getData(context).then((value) {
      setState(() {
        onLoading = false;
        rotaItemList = value;
      });
    });
  }

  getChartData() async {
    setState(() {
      onLoadingChart = true;
    });

    await RotaCidadeItemList.getData(context, curRota!.id).then((value) {
      setState(() {
        chartData = [];

        for (final item in value) {
          chartData.add(ChartData(item.cidade.nome, item.valorTotal));
        }

        onLoadingChart = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // onLoading = false;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    bool smallScreen = width < 1000.0;
    bool verySmallScreen = width < 720.0;
    bool showDrawer = MediaQuery.of(context).size.width > 1500;
    final size = AppSize.of(context);

    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Contas'),
      ),
      loading: false,
      body: Container(
        // child: ,
      ),
    );
  }
}
