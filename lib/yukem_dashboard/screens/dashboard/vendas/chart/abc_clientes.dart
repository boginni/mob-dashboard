import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/container_loading.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/vendas/moddels/abc_pessoa.dart';

import '../../../../component/chart_container.dart';

class ListABCClientes extends StatefulWidget {
  const ListABCClientes({Key? key}) : super(key: key);

  @override
  State<ListABCClientes> createState() => _ListABCClientesState();
}

class _ListABCClientesState extends State<ListABCClientes> {
  List<ABCCliente> series = [];

  bool onLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ABCCliente.getData(context).then((value) {
        setState(() {
          onLoading = false;
          series = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChartContainer(
      title: ChartContainerTitle('Melhores clientes'),
      child: SizedBox(
        width: 300,
        height: 600,
        child: ContainerAfterLoading(
          onLoading: onLoading,
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: series.length,
            padding: EdgeInsets.only(right: 10),
            itemBuilder: (context, index) {
              final item = series[index];
              return _Tile(item: item);
            },
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({Key? key, required this.item}) : super(key: key);

  final ABCCliente item;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // const Icon(CupertinoIcons.cube_box, size: 64,),
            // const SizedBox(
            //   width: 8,
            // ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.pessoa.nome,
                        style: theme.textTheme.title3(size: 10)),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0),
                    //   child: Text('x${NumberFormat.decimalPattern('pt-br').format(item.qtdComercial)}'),
                    // )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                      '${NumberFormat.simpleCurrency(locale: 'pt-br').format(item.valorTotal)}',
                      style: theme.textTheme.title3(size: 12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
