import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/container_loading.dart';

import '../../../../component/chart_container.dart';
import '../moddels/abc_produto.dart';

class ListABCProdutos extends StatefulWidget {
  const ListABCProdutos({Key? key}) : super(key: key);

  @override
  State<ListABCProdutos> createState() => _ListABCProdutosState();
}

class _ListABCProdutosState extends State<ListABCProdutos> {
  List<ABCProduto> series = [];

  bool onLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ABCProduto.getData(context, '2022', '10').then((value) {
        setState(() {
          onLoading = false;
          series = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerAfterLoading(
      onLoading: onLoading,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 10),
        itemCount: series.length,
        itemBuilder: (context, index) {
          final item = series[index];
          return _Tile(item: item);
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({Key? key, required this.item}) : super(key: key);

  final ABCProduto item;

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
                  children: [
                    Text(item.produto.nome, style: theme.textTheme.title3(size: 10)),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0),
                    //   child: Text('x${NumberFormat.decimalPattern('pt-br').format(item.qtdComercial)}',  style: theme.textTheme.title2(size: 8)),
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
                      '${NumberFormat.simpleCurrency(locale: 'pt-br').format(item.valorTotal)}', style: theme.textTheme.title3(size: 12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
