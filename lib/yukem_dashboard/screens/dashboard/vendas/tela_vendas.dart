import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/chart_container.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/charts/cartesian/bar_chart.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/charts/pie_chart/pie_chart.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/connection/server_routes.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/connection/super_query.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/chart_data.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/vendedor.dart';

import '../../../../sdk/common/components/app_bar/date_selection.dart';
import '../../../../sdk/models/configuracao/app_theme.dart';
import '../../../component/drawer/custom_scaffold.dart';
import '../../../component/drawer/drawer_selecao.dart';
import '../../../component/form_date_picker.dart';

class TelaVendas extends StatefulWidget {
  const TelaVendas({Key? key}) : super(key: key);

  @override
  State<TelaVendas> createState() => _TelaVendasState();
}

class _TelaVendasState extends State<TelaVendas> {
  List<Vendedor> vendedores = [];
  bool onLoading = true;

  Map<String, DataSeries> series = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      vendedores = await Vendedor.getDataFilter(context);
      getData();
    });
  }

  getData() async {
    SuperQuery.simpleData(
      context,
      ServerRoutes.comercial_page,
      dataIni: DateTime.now(),
      dataFim: DateTime.now(),
    ).then((value) {
      setState(() {
        onLoading = false;
        series = value;
      });
    });
  }

  List<ChartData> getSeries(DataSeries? dataSeries) {
    if (dataSeries == null) {
      return [];
    }

    return dataSeries.series;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return CustomScaffold(
      appBar: AppBar(
        title: const Text('TelaVendas'),
        actions: [
          AppBarMonthSelection(onChange: (x) {
            setState(() {});
          })
        ],
      ),
      endDrawer: DrawerSelecaoVendedor(
        onChanged: () {},
        itens: vendedores,
        onLoading: onLoading,
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ChartContainer(
                    title: ChartContainerTitle('Intervalo'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: FormDatePicker(
                              firstDate: DateTime(2000, 1, 1),
                              initialDate:
                                  DateTime.now().add(const Duration(days: -30)),
                              lastDate: DateTime(2100, 1, 1),
                              then: (DateTime? date) {
                                if (date != null) {}
                              },
                              decoration: InputDecoration(
                                hintStyle: theme.textTheme.body(),
                                hintText: 'Data Inicio',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: FormDatePicker(
                              firstDate: DateTime(2000, 1, 1),
                              initialDate:
                                  DateTime.now().add(const Duration(days: -30)),
                              lastDate: DateTime(2100, 1, 1),
                              then: (DateTime? date) {
                                if (date != null) {}
                              },
                              decoration: InputDecoration(
                                hintStyle: theme.textTheme.body(),
                                hintText: 'Data Fim',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
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
                  ChartContainer(
                    title: const ChartContainerTitle('Origem'),
                    child: PieChart(
                      outerLegend: false,
                      dataSeries: getSeries(series['pedido_origem']),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ChartContainer(
                          title: const ChartContainerTitle('Tipos de Cliente'),
                          child: PieChart(
                            dataSeries: getSeries(series['cliente_tipo']),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ChartContainer(
                          title: const ChartContainerTitle('Departamento'),
                          child: PieChart(
                            dataSeries:
                                getSeries(series['produto_departamento']),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ChartContainer(
                        title: const ChartContainerTitle('Vendedores'),
                        width: 400,
                        height: 600,
                        expanded: true,
                        child: ChartBarRows(
                          dataSeries:
                              series['ranking_vendedor'] ?? DataSeries('', []),
                        ),
                      ),
                      ChartContainer(
                        title: const ChartContainerTitle('Clientes'),
                        width: 400,
                        height: 600,
                        expanded: true,
                        child: ChartBarRows(
                          dataSeries: series['ranking_cliente'] ?? DataSeries('', []),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
