import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/container_loading.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/produto.dart';

import '../tiles/util/tile_produto.dart';

class TelaSelecionarProduto extends StatefulWidget {
  const TelaSelecionarProduto({Key? key, required this.onPressed})
      : super(key: key);

  final Function(Produto item) onPressed;

  @override
  State<TelaSelecionarProduto> createState() => _TelaSelecionarProdutoState();
}

class _TelaSelecionarProdutoState extends State<TelaSelecionarProduto> {
  TextEditingController controllerPesquisa = TextEditingController();

  List<Produto> listProdutos = [];
  bool onLoadingListProdutos = true;

  getProdutoList() {
    Produto.getData(context, mobile: true, filter: controllerPesquisa.text)
        .then((value) {
      setState(() {
        listProdutos = value;
        onLoadingListProdutos = false;
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProdutoList();
    });
  }


  Timer? t;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (t != null && t!.isActive) {
      t!.cancel();
    }
  }

  int curPage = 0;
  int resultLimit = 20;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Text(
                    'Pesquisar Produto',
                    style: theme.textTheme.title(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controllerPesquisa,
                            onChanged: (value) {
                              if (t != null && t!.isActive) {
                                t!.cancel();
                              }

                              setState(() {
                                t = Timer(Duration(milliseconds: 300), () {
                                  getProdutoList();
                                });
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        TextButton(
                          onPressed: () {
                            getProdutoList();
                          },
                          child: Text(
                            'Pesquisar',
                            style: theme.textTheme.subTitle2(),
                          ),
                          style: theme.buttonStyle,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      if (t != null && t!.isActive) CircularProgressIndicator(),
                      Text(
                        '${listProdutos.length} Resultados',
                        style: theme.textTheme.title2(),
                      ),
                      if (listProdutos.length > resultLimit)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Monstrando somente os'),
                            Text(
                              ' $resultLimit ',
                              style: theme.textTheme.body(color: Colors.red),
                            ),
                            const Text('primeiros'),
                          ],
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContainerAfterLoading(
                onLoading: onLoadingListProdutos,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(16, 0, 24, 12),
                      itemCount: listProdutos.length > resultLimit
                          ? resultLimit
                          : listProdutos.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = listProdutos[index];

                        return TileProduto(
                          item: item,
                          onPressed: () {
                            widget.onPressed(item);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Produto?> selecionarProduto(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            side: BorderSide(
                color: AppTheme.of(context).colorTheme.primaryColor)),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
              height: height - 200,
              width: width - 400,
              child: TelaSelecionarProduto(onPressed: (Produto p) {
                Navigator.of(context).pop(p);
              }),
            );
          },
        ),
      );
    },
  );
}
