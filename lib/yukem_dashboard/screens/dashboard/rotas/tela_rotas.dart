import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/common/components/app_bar/date_selection.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/rotas/chart/chart_rota.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/rotas/moddels/rota_item_list.dart';

import '../../../../sdk/models/configuracao/app_theme.dart';
import '../../../component/drawer/custom_scaffold.dart';

class TelaRotas extends StatefulWidget {
  const TelaRotas({Key? key}) : super(key: key);

  @override
  State<TelaRotas> createState() => _TelaRotasState();
}

class _TelaRotasState extends State<TelaRotas> {
  late bool onLoading = true;
  final _controller = ScrollController();
  List<RotaItemList> rotaItemList = [];

  getData() async {
    await RotaItemList.getData(context).then((value) {
      setState(() {
        onLoading = false;
        rotaItemList = List<RotaItemList>.from(value.reversed);
        // rotaSeries = [];
        // for (final item in rotaItemList) {
        //   rotaSeries.add(ChartData(item.rota.nome, item.valorTotal));
        // }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Rotas'),
        actions: [
          AppBarMonthSelection(
            onChange: (date) {},
          ),
        ],
      ),
      loading: onLoading,
      body: Column(
        children: [
          ChartRotas(
            rotaItemList: rotaItemList,
          )
        ],
      ),
    );
  }
}
