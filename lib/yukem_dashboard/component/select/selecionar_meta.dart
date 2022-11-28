import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/container_loading.dart';

import '../../screens/operador/metas/moddels/meta.dart';
import '../../screens/operador/metas/tiles/tile_meta_cab.dart';

class TelaSelecionarMeta extends StatefulWidget {
  const TelaSelecionarMeta({Key? key, required this.onPressed})
      : super(key: key);

  final Function(Meta m) onPressed;

  @override
  State<TelaSelecionarMeta> createState() => _TelaSelecionarMetaState();
}

class _TelaSelecionarMetaState extends State<TelaSelecionarMeta> {
  TextEditingController controllerPesquisa = TextEditingController();

  List<Meta> listMetas = [];
  bool onLoading = true;

  getListMeta() {
    Meta.getData(context).then((value) {
      setState(() {
        value.removeWhere((element) => element.status == 0);
        listMetas = value;
        onLoading = false;
      });
    });
  }

  Timer? t;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getListMeta();
    });
  }

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
          if(false)
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Text(
                    'Pesquisar Metas',
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
                                  getListMeta();
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
                            getListMeta();
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
                        '${listMetas.length} Resultados',
                        style: theme.textTheme.title2(),
                      ),
                      if (listMetas.length > resultLimit)
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
                onLoading: onLoading,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(16, 0, 24, 12),
                      itemCount: listMetas.length > resultLimit
                          ? resultLimit
                          : listMetas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = listMetas[index];

                        return TileMetaCab(
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

Future<Meta?> selecionarMeta(BuildContext context) async {
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
              child: TelaSelecionarMeta(
                onPressed: (Meta m) {
                  Navigator.of(context).pop(m);
                },
              ),
            );
          },
        ),
      );
    },
  );
}
