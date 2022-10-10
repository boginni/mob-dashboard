import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/chart_container.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/vendas/chart/chart_contas.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/vendas/tiles/card_main.dart';

import '../../../../sdk/models/configuracao/app_connection.dart';
import '../../../../sdk/models/configuracao/app_theme.dart';
import '../../../component/drawer/custom_drawer.dart';
import '../../../models/connection/server_routes.dart';
import 'chart/abc_clientes.dart';
import 'chart/abc_produtos.dart';
import 'chart/vendas_data.dart';
import 'moddels/chart_data.dart';
import 'moddels/series_cast.dart';

class TelaVendas extends StatefulWidget {
  const TelaVendas({Key? key}) : super(key: key);

  @override
  State<TelaVendas> createState() => _TelaVendasState();
}

class _TelaVendasState extends State<TelaVendas> {
  List<DataSeries> seriesVendaAno = [];
  List<DataSeries> seriesVendaMes = [];

  List<DataSeries> seriesContasPagar = [];
  List<DataSeries> seriesContasReceber = [];

  late bool onLoadingDataSeries = true;

  Map<String, dynamic>? dataSeries;
  final _controller = ScrollController();

  getData() async {
    final app = AppConnection.of(context);
    await app
        .getResult(ServerRoutes.main_tela, body: {}, headers: {}).then((value) {
      final listA = SeriesCast.castRawSeries(
          value['seriesVendasAno'], (row) => ChartData(row[0], row[1]));

      final listB = SeriesCast.castRawSeries(
          value['seriesVendasMes'], (row) => ChartData(row[0], row[1]));

      final listC = SeriesCast.castRawContas(value['seriesContasPagar']);

      final listD = SeriesCast.castRawContas(value['seriesContasReceber']);

      setState(() {
        dataSeries = value;
        seriesVendaAno = listA;
        seriesVendaMes = listB;
        seriesContasPagar = listC;
        seriesContasReceber = listD;
        onLoadingDataSeries = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    onLoadingDataSeries = false;
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

    final abc = [
      const ListABCProdutos(),
      const ListABCClientes(),
    ];

    final series = [];

    final contas = [
      ChartContas(
        dataSeries: seriesContasPagar,
        interval: 5,
        title: 'Contas a Pagar',
      ),
      ChartContas(
        dataSeries: seriesContasReceber,
        interval: 5,
        title: 'Contas a Receber',
      ),
    ];

    return CustomScaffold(
        minWidth: 1200,
        appBar: AppBar(
          title: const Text('Vendas'),
        ),
        loading: onLoadingDataSeries,
        body: SingleChildScrollView(
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
          child: RefreshIndicator(
            onRefresh: () async {
              await getData();
            },
            child: Column(
              children: [
                /**
                 * CARDs
                 */
                _HeaderCards(dataSeries: dataSeries),

                Row(
                  mainAxisAlignment: MainAxisAlignment.cente,
                  children: [
                    ChartContainer(
                      title: ChartContainerTitle('Series do Ano'),
                      child: ChartVendas(
                        dataSeries: seriesVendaAno,
                      ),
                    ),
                    ChartContainer(
                      title: ChartContainerTitle('Series do Mês'),
                      child: ChartVendas(
                        dataSeries: seriesVendaMes,
                        interval: 3,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ListABCProdutos(),
                    const ListABCClientes(),
                    ChartContas(
                      dataSeries: seriesContasPagar,
                      interval: 5,
                      title: 'Contas a Pagar',
                    ),
                    ChartContas(
                      dataSeries: seriesContasReceber,
                      interval: 5,
                      title: 'Contas a Receber',
                    ),
                  ],
                )

                // Row(
                //   children: [abc, series],
                // )
              ],
            ),
          ),
        ));
  }
}

class _HeaderCards extends StatelessWidget {
  const _HeaderCards({Key? key, required this.dataSeries}) : super(key: key);

  final Map<String, dynamic>? dataSeries;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // print(width);

    bool row = width > 1300;

    final tiles = [
      MainCardTile(
        titulo: 'Vendas do Ano',
        valor: dataSeries == null ? null : dataSeries!['anoAtual'].toString(),
      ),
      MainCardTile(
        titulo: 'Mes Atual',
        valor:
            dataSeries == null ? null : dataSeries!['anoAnterior'].toString(),
      ),
      MainCardTile(
        titulo: 'Vendas do Mês',
        valor: dataSeries == null ? null : dataSeries!['mesAtual'].toString(),
      ),
      MainCardTile(
        titulo: 'Mês Passado',
        valor:
            dataSeries == null ? null : dataSeries!['mesAnterior'].toString(),
      ),
    ];

    return row
        ? Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.center,
            children: tiles,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [tiles[0], tiles[1]],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [tiles[2], tiles[3]],
              )
            ],
          );
  }
}
