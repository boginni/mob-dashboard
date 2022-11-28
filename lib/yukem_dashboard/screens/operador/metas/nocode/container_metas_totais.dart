import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

import '../components/container_meta_header.dart';
import '../moddels/meta.dart';
import '../moddels/meta_item_total.dart';
import '../moddels/meta_item_vendedor.dart';
import '../tiles/tile_meta_item_total.dart';
import '../tiles/tile_meta_item_vendedor.dart';

class ContainerMetaTotais extends StatefulWidget {
  const ContainerMetaTotais({Key? key, required this.meta}) : super(key: key);

  final Meta meta;

  @override
  State<ContainerMetaTotais> createState() => _ContainerMetaTotaisState();
}

class _ContainerMetaTotaisState extends State<ContainerMetaTotais> {
  bool onLoadingItemList = true;

  MetaItemTotal? curItemTotal;

  List<MetaItemTotal> listMetaItensTotal = [];
  List<MetaItemVendedor> listMetaItensVendedor = [];

  getMetaItemTotalList() {
    MetaItemTotal.getData(context, idMeta: widget.meta.id).then((value) {
      setState(() {
        listMetaItensTotal = value;
        // header = MetaHeader.sample();
        onLoadingItemList = false;
      });
    });
  }

  getMetaItemVendedorList() {
    MetaItemVendedor.getData(
      context,
      idMeta: widget.meta.id,
      idProduto: curItemTotal!.idProduto,
    ).then((value) {
      setState(() {
        listMetaItensVendedor = value;
        // header = MetaHeader.sample();
        onLoadingItemList = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMetaItemTotalList();
    });
  }

  int? lastMeta;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);

    bool b = lastMeta != widget.meta.id && lastMeta != null;

    if (b) {
      onLoadingItemList = true;
      curItemTotal = null;
      listMetaItensTotal = [];
      listMetaItensVendedor = [];

      getMetaItemTotalList();
    }

    lastMeta = widget.meta.id;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ContainerMetaHeader(meta: widget.meta),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listMetaItensTotal.length,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.only(right: 12),
                  itemBuilder: (context, index) {
                    final item = listMetaItensTotal[index];
                    return TileMetaItemTotal(
                      item: item,
                      onSelected: item == curItemTotal,
                      onPressed: () {
                        if (item == curItemTotal) {
                          return;
                        }
                        setState(() {
                          listMetaItensVendedor = [];
                          curItemTotal = item;
                        });
                        getMetaItemVendedorList();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        VerticalDivider(),
        Flexible(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: theme.colorTheme.primaryColor,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Desempenho',
                        style: theme.textTheme.title(
                            color: theme.colorTheme.primaryColorBackground),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listMetaItensVendedor.length,
                  itemBuilder: (context, index) {
                    final item = listMetaItensVendedor[index];
                    return TileMetaItemVendedor(
                      item: item,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
