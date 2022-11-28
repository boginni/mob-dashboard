import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/operador/metas/tiles/tile_meta_cab.dart';

import '../../../component/drawer/custom_scaffold.dart';
import 'components/container_selecione_meta.dart';
import 'components/themed_button.dart';
import 'moddels/meta.dart';
import 'nocode/container_metas_gerenciar.dart';
import 'nocode/container_metas_totais.dart';
import 'nocode/container_metas_vendedor.dart';

class TelaMetas extends StatefulWidget {
  const TelaMetas({Key? key}) : super(key: key);

  @override
  State<TelaMetas> createState() => _TelaMetasState();
}

class _TelaMetasState extends State<TelaMetas> {
  List<Meta> listMetas = [];

  bool onLoading = true;
  int? curMeta;

  getData() {
    Meta.getData(context).then((value) {
      setState(() {
        value.removeWhere((element) => element.status == 0);
        listMetas = value;
        onLoading = false;
      });
    }).catchError((err) {
      onLoading = true;
      print(err);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  ScrollController scroll = ScrollController();

  setScreen(int? i) {
    setState(() {
      if (i != null) {
        curScreen = i;
      } else {
        curMeta = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return CustomScaffold(
      loading: onLoading,
      appBar: AppBar(
        title: const Text('Gerenciar Metas'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              controller: scroll,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Card(
                      color: theme.colorTheme.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Metas',
                              style: theme.textTheme.title(
                                color: theme.colorTheme.primaryColorBackground,
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Icon(
                                  Icons.add,
                                  color:
                                      theme.colorTheme.primaryColorBackground,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  curMeta = -1;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: listMetas.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final item = listMetas[index];

                        final bool onSelected = curMeta == index;

                        return TileMetaCab(
                          item: item,
                          onPressed: () {
                            // if (onSelected) {
                            //   return;
                            // }
                            setState(() {
                              curMeta = index;
                            });
                          },
                          onSelected: onSelected,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          children: [
                            Expanded(
                                child: ThemedButton(
                              text: 'Gerenciar',
                              onSelected: curScreen == 0,
                              onPressed: () {
                                setScreen(0);
                              },
                            )),
                            Expanded(
                              child: ThemedButton(
                                text: 'Vendedor',
                                onSelected: curScreen == 1,
                                onPressed: () {
                                  setScreen(1);
                                },
                              ),
                            ),
                            Expanded(
                              child: ThemedButton(
                                text: 'Total',
                                onSelected: curScreen == 2,
                                onPressed: () {
                                  setScreen(2);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (curMeta == null) {
                              return const Center(
                                  child:
                                      ContainerSelecioneMeta(condition: false));
                            }

                            late final Meta meta;

                            if (curMeta == -1) {
                              meta = Meta.add();
                            } else {
                              meta = listMetas[curMeta!];
                            }

                            final screens = <Widget>[
                              ContainerMetaGerenciar(
                                meta: meta,
                                onRemove: () {
                                  setState(() {
                                    curMeta = null;
                                    // mostrarMetas = false;
                                    // onFinished = false;
                                    getData();
                                  });
                                },
                                onSave: () {
                                  getData();
                                },
                              ),
                              ContainerMetaVendedor(
                                  meta: meta,
                                  onUpdate: () {
                                    getData();
                                  }),
                              ContainerMetaTotais(
                                meta: meta,
                              )
                            ];

                            return screens[curScreen];
                          },
                        ),
                      ),
                      // ContainerSelecioneMeta(
                      //   condition: curMeta == null,
                      //   child: ContainerMetaVendedor(meta: curMeta!),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  int curScreen = 0;
}
