import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/common/components/app_bar/date_selection.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/vendedor.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/rotas/chart/chart_rota.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/rotas/moddels/rota_item_list.dart';

import '../../../component/chart_container.dart';
import '../../../component/charts/list_chart.dart';
import '../../../component/charts/pie_chart/pie_chart.dart';
import '../../../component/drawer/custom_scaffold.dart';
import '../../../component/drawer/drawer_selecao.dart';
import '../../../models/sample/sample_data.dart';
import '../main/chart/vendas_data.dart';

class TelaRotas extends StatefulWidget {
  const TelaRotas({Key? key}) : super(key: key);

  @override
  State<TelaRotas> createState() => _TelaRotasState();
}

class _TelaRotasState extends State<TelaRotas> {
  late bool onLoading = true;
  final _controller = ScrollController();
  List<RotaItemList> rotaItemList = [];
  List<Vendedor> vendedores = [];

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
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Vendedor.getDataFilter(context).then((value) {
          setState(() {
            vendedores = value;
            getData();
          });
        });
      });
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
      endDrawer: DrawerSelecaoVendedor(
        onChanged: () {},
        itens: vendedores,
        onLoading: onLoading,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChartContainer(
                  width: 320,
                  title: ChartContainerTitle('Pedidos'),
                  child: Container(),
                ),
                ChartContainer(
                  width: 320,
                  title: ChartContainerTitle('Clientes'),
                  child: Container(),
                ),
                ChartContainer(
                  width: 320,
                  title: ChartContainerTitle('Faturamento'),
                  child: Container(),
                ),
                ChartContainer(
                  width: 320,
                  title: ChartContainerTitle('Médio'),
                  child: Container(),
                ),
              ],
            ),
            Row(
              children: [
                ChartContainer(
                  width: 500,
                  height: 714,
                  expanded: true,
                  title: ChartContainerTitle('Rotas'),
                  child: ChartRotas(
                    rotaItemList: rotaItemList,
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ChartContainer(
                              title: const ChartContainerTitle('Departamento'),
                              child: PieChart(
                                dataSeries: SampleData.RandomPie(qtd: 2),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ChartContainer(
                              title: const ChartContainerTitle('Vendedores'),
                              child: PieChart(
                                dataSeries: SampleData.RandomPie(qtd: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListCharts(
                        title: 'Tipo de Cliente',
                        charts: [
                          ChartItem(
                            icon: Icons.pie_chart,
                            nome: 'Series',
                            chart: ChartVendas(
                              dataSeries: [
                                SampleData.RandomSeriesInt('01'),
                                SampleData.RandomSeriesInt('02'),
                                SampleData.RandomSeriesInt('03')
                              ],
                            ),
                          ),
                          ChartItem(
                            icon: Icons.pie_chart,
                            nome: 'Torta',
                            chart: PieChart(
                              dataSeries: SampleData.RandomPie(qtd: 3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
