import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/chart_container.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/charts/cartesian/bar_chart.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/charts/pie_chart/pie_chart.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/vendedor.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/sample/sample_data.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Vendedor.getDataFilter(context).then((value) {
        setState(() {
          onLoading = false;
          vendedores = value;
        });
      });
    });
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
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
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
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
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
                      dataSeries: SampleData.RandomPie(qtd: 2),
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
                            dataSeries: SampleData.RandomPie(qtd: 2),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ChartContainer(
                          title: const ChartContainerTitle('Departamento'),
                          child: PieChart(
                            dataSeries: SampleData.RandomPie(qtd: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [

                      ChartContainer(
                        title: ChartContainerTitle('Vendedores'),
                        width: 400,
                        height: 600,
                        expanded: true,
                        child: ChartBarRows(
                          dataSeries: SampleData.RandomSeriesInt(''),
                        ),
                      ),
                      ChartContainer(
                        title: ChartContainerTitle('Clientes'),
                        width: 400,
                        height: 600,
                        expanded: true,
                        child: ChartBarRows(
                          dataSeries: SampleData.RandomSeriesInt(''),
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
