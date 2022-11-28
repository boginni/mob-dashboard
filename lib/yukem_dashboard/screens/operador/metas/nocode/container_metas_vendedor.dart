import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/select/selecionar_produto.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/produto.dart';

import '../components/buttons.dart';
import '../components/container_meta_header.dart';
import '../moddels/meta.dart';
import '../moddels/meta_item.dart';
import '../moddels/meta_vendedor.dart';
import '../tiles/tile_meta_item.dart';
import '../tiles/tile_meta_vendedor.dart';

class ContainerMetaVendedor extends StatefulWidget {
  const ContainerMetaVendedor(
      {Key? key, required this.meta, required this.onUpdate})
      : super(key: key);

  final Meta meta;
  final Function onUpdate;

  @override
  State<ContainerMetaVendedor> createState() => _ContainerMetaVendedorState();
}

class _ContainerMetaVendedorState extends State<ContainerMetaVendedor> {
  bool onLoadingItemList = true;
  bool onLoadingVendedorList = true;

  int? curVendedor;

  List<MetaItem> listMetaItens = [];
  List<MetaVendedor> listMetaVendedor = [];

  getListMetaVendedor() {
    MetaVendedor.getData(context, idMeta: widget.meta.id).then((value) {
      setState(() {
        listMetaVendedor = value;
        onLoadingVendedorList = false;
      });
    }).catchError((err) {
      onLoadingVendedorList = true;
      print(err);
    });
  }

  getListMetaItem() {
    MetaItem.getData(context,
            idMeta: widget.meta.id,
            idVendedor: listMetaVendedor[curVendedor!].id)
        .then((value) {
      setState(() {
        listMetaItens = value;
        onLoadingItemList = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getListMetaVendedor();
    });
  }

  editItem(MetaItem? item) {
    item =
        item ?? MetaItem.add(widget.meta.id, listMetaVendedor[curVendedor!].id);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _EditProduto(metaItem: item!, qtd: item.qtdMeta);
      },
    ).then((value) {
      if (value != null) {
        (value as MetaItem).salvar(context).then((value) {
          getListMetaItem();
          getListMetaVendedor();
          widget.onUpdate();
        });
      }
    });
  }

  int? lastMeta;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);

    bool b = lastMeta != widget.meta.id && lastMeta != null;

    if (b) {
      listMetaItens = [];
      listMetaVendedor = [];

      curVendedor = null;

      onLoadingVendedorList = true;

      getListMetaVendedor();
    }

    lastMeta = widget.meta.id;

    final controllerItem = ScrollController();
    final controllerVendedor = ScrollController();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: SingleChildScrollView(
            controller: controllerVendedor,
            child: Column(
              children: [
                Card(
                  shadowColor: Colors.black,
                  color: theme.colorTheme.primaryColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 22),
                      child: Text(
                        'Vendedores',
                        style: theme.textTheme.title(
                            color: theme.colorTheme.primaryColorBackground),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listMetaVendedor.length,
                  itemBuilder: (context, index) {
                    final item = listMetaVendedor[index];
                    return TileMetaVendedor(
                      item: item,
                      onSelected: index == curVendedor,
                      onPressed: () {
                        if (index == curVendedor) {
                          return;
                        }
                        setState(() {
                          curVendedor = index;
                          listMetaItens = [];
                        });

                        getListMetaItem();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          flex: 3,
          child: SingleChildScrollView(
            controller: controllerItem,
            child: Column(
              children: [
                ContainerMetaHeader(
                  meta: widget.meta,
                  vendedor: curVendedor == null
                      ? null
                      : listMetaVendedor[curVendedor!],
                ),
                if (curVendedor != null)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: SizedBox(
                      width: double.infinity, // <-- match_parent
                      height: 40,
                      child: TextButton(
                        style: theme.buttonStyle,
                        child: Text('Adicionar Produto',
                            style: theme.textTheme.subTitle2()),
                        onPressed: () {
                          editItem(null);
                        },
                      ),
                    ),
                  ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listMetaItens.length,
                  itemBuilder: (context, index) {
                    final item = listMetaItens[index];
                    return TileMetaItem(
                      item: item,
                      editable: true,
                      onEdit: () {
                        editItem(item);
                      },
                      onRemove: () {
                        item.remove(context).then((value) {
                          getListMetaItem();
                          getListMetaVendedor();
                          widget.onUpdate();
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EditProduto extends StatefulWidget {
  const _EditProduto({Key? key, required this.metaItem, this.qtd})
      : super(key: key);

  final MetaItem metaItem;
  final int? qtd;

  @override
  State<_EditProduto> createState() => _EditProdutoState();
}

class _EditProdutoState extends State<_EditProduto> {
  late Produto produto;

  TextEditingController controllerMeta = TextEditingController();

  @override
  void initState() {
    super.initState();
    produto = widget.metaItem.toProduto();
    controllerMeta.text = (widget.qtd ?? 0).toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        color: theme.colorTheme.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: theme.colorTheme.primaryColor,
                    child: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          'Editar Meta',
                          style: theme.textTheme.title(
                              color: theme.colorTheme.primaryColorBackground),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            'Quantidade Meta',
                            style: theme.textTheme.subTitle(),
                          )),
                          SizedBox(
                            width: 64,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: controllerMeta,
                              obscureText: false,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      if (false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              'Valor Meta',
                              style: theme.textTheme.subTitle(),
                            )),
                            SizedBox(
                              width: 64,
                            ),
                            Flexible(
                              child: TextFormField(
                                // controller: controllerMeta,
                                obscureText: false,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Produto',
                              style: theme.textTheme.subTitle(),
                            ),
                          ),
                          const SizedBox(
                            width: 64,
                          ),
                          TextButton(
                            onPressed: () {
                              selecionarProduto(context).then((value) {
                                setState(() {
                                  if (value != null) {
                                    produto = value;
                                  }
                                });
                              });
                            },
                            style: theme.buttonStyle,
                            child: Text(
                              produto.nome,
                              style: theme.textTheme.subTitle2(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RemoveButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: 'Cancelar',
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          Expanded(
                            child: SaveButton(
                              onActive: produto.id != 0,
                              onPressed: () {
                                widget.metaItem.qtdMeta =
                                    int.tryParse(controllerMeta.text) ?? 0;
                                widget.metaItem.idProduto = produto.id;
                                widget.metaItem.nomeProduto = produto.nome;
                                Navigator.of(context).pop(widget.metaItem);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
