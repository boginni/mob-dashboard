import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yukem_dashboard/sdk/common/components/app_bar/date_selection.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/main/tiles/card_main.dart';

import '../../../../sdk/models/configuracao/app_connection.dart';
import '../../../component/chart_container.dart';
import '../../../component/drawer/custom_scaffold.dart';
import '../../../models/connection/server_routes.dart';
import 'chart/cartesian_abc_produtos.dart';
import 'chart/chart_contas.dart';
import 'chart/vendas_data.dart';
import 'moddels/abc_produto.dart';
import '../../../models/data_ojects/chart_data.dart';
import 'moddels/series_cast.dart';

class TelaDashboardMain extends StatefulWidget {
  const TelaDashboardMain({Key? key}) : super(key: key);

  @override
  State<TelaDashboardMain> createState() => _TelaDashboardMainState();
}

class _TelaDashboardMainState extends State<TelaDashboardMain> {
  rezetData() {
    seriesVendaAno = [];
    seriesVendaMes = [];
    seriesContasPagar = [];
    seriesContasReceber = [];
    seriesContasPagarMes = [];
    seriesContasReceberMes = [];
    seriesABCProdutos = [];
    // onLoadingDataSeries = true;
    cards = null;
  }

  late List<DataSeries> seriesVendaAno = [];
  late List<DataSeries> seriesVendaMes = [];
  late List<DataSeries<DateTime>> seriesContasPagar = [];
  late List<DataSeries<DateTime>> seriesContasReceber = [];
  late List<DataSeries<DateTime>> seriesContasPagarMes = [];
  late List<DataSeries<DateTime>> seriesContasReceberMes = [];
  List<ChartData<String>> seriesABCProdutos = [];

  late bool onLoadingDataSeries = true;

  Map<String, dynamic>? cards;
  final _controller = ScrollController();

  getData() async {
    final app = AppConnection.of(context);
    final dataAno = DateFormat('yyyy').format(curDate);
    final dataMes = DateFormat('MM').format(curDate);
    await app.getResult(ServerRoutes.main_tela,
        body: {'dataAno': dataAno, 'dataMes': dataMes}).then((value) {
      final listA = SeriesCast.castRawSeries(value['seriesVendasAno'],
          (row) => ChartData(row[0], row[1].toDouble()));
      final listB = SeriesCast.castRawSeries(value['seriesVendasMes'],
          (row) => ChartData(row[0], row[1].toDouble()));

      final List<ChartData<String>> listABC = [];

      ABCProduto.castData(value['abcProdutos']).forEach((element) {
        listABC
            .add(ChartData<String>(element.produto.nome, element.valorTotal));
      });

      setState(() {
        cards = value['cards'][0];
        seriesVendaAno = listA;
        seriesVendaMes = listB;
        //
        seriesContasPagar =
            SeriesCast.castRawContas(value['seriesContasPagar']);
        seriesContasReceber =
            SeriesCast.castRawContas(value['seriesContasReceber']);
        //
        seriesContasPagarMes =
            SeriesCast.castRawContas(value['seriesContasPagarMes']);
        seriesContasReceberMes =
            SeriesCast.castRawContas(value['seriesContasReceberMes']);

        seriesABCProdutos = listABC;
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

  DateTime curDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return CustomScaffold(
      // minWidth: 1200,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          AppBarMonthSelection(onChange: (x) {
            setState(() {
              curDate = x;
              rezetData();
              getData();
            });
          })
        ],
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
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _HeaderCards(cards: cards),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ChartContainer(
                        title: ChartContainerTitle('Faturamento Mês'),
                        child: ChartVendas(dataSeries: seriesVendaAno),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ChartContainer(
                        title: const ChartContainerTitle('Faturamento Dia'),
                        child: ChartVendas(dataSeries: seriesVendaMes),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ChartContainer(
                        height: 392,
                        title: ChartContainerTitle('ABC Produtos'),
                        child: ChartABCProdutos(
                          dataSeries: seriesABCProdutos,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ChartContas(
                        height: 392,
                        seriesAno: seriesContasPagar,
                        seriesMes: seriesContasPagarMes,
                        title: 'Contas a Pagar',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ChartContas(
                        height: 392,
                        seriesAno: seriesContasReceber,
                        seriesMes: seriesContasReceberMes,
                        title: 'Contas a Receber',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCards extends StatelessWidget {
  const _HeaderCards({Key? key, required this.cards}) : super(key: key);

  final Map<String, dynamic>? cards;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    List<String?> value = List.filled(5, null);

    if (cards != null) {
      final f = NumberFormat.simpleCurrency(locale: 'PT-BR');

      value[0] = f.format(cards!['VALOR_PRODUTOS']);
      value[1] = f.format(cards!['LUCRO']);
      value[2] = cards!['VENDAS'].toString();
      value[3] = f.format(cards!['TICKET_MEDIO']);
      value[4] = cards!['CLIENTES'].toString();
    }

    final tiles = [
      DashboardCard(
        titulo: 'Faturamento',
        valor: value[0],
        icon: Icons.shopping_cart,
      ),
      DashboardCard(
        titulo: 'Lucro',
        valor: value[1],
        icon: Icons.monetization_on,
      ),
      DashboardCard(
        titulo: 'Vendas',
        valor: value[2],
        icon: Icons.area_chart,
      ),
      DashboardCard(
        titulo: 'Tiket Médio',
        valor: value[3],
        icon: CupertinoIcons.tag_fill,
      ),
      DashboardCard(
        titulo: 'Clientes Atendidos',
        valor: value[4],
        icon: Icons.people,
      ),
    ];

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisAlignment: MainAxisAlignment.center,
      children: tiles,
    );
  }
}
