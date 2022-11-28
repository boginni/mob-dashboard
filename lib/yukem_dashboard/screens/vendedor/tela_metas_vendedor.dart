import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/container_loading.dart';

import '../../../sdk/common/formatter/date_time_formatter.dart';
import '../../component/drawer/custom_drawer.dart';
import '../operador/metas/tiles/tile_meta_item.dart';

class TelaMetasVendedor extends StatefulWidget {
  const TelaMetasVendedor({Key? key}) : super(key: key);

  @override
  State<TelaMetasVendedor> createState() => _TelaMetasVendedorState();
}

class _TelaMetasVendedorState extends State<TelaMetasVendedor> {

  bool isLoading = true;

  List<dynamic> itens = [];
  Map<String, dynamic> header = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

    });
  }

  @override
  Widget build(BuildContext context) {
    final list = SingleChildScrollView(
      child: Column(
        children: [
          if (header.isNotEmpty)
            Card(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(header['NOME_META']),
                          Text(
                              '${DateFormatter.normalData.format(DateTime.parse(header['DATA_INICIO']))} - ${DateFormatter.normalData.format(DateTime.parse(header['DATA_FIM']))}')
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vendedor'),
                        Text(header['NOME_VENDEDOR'].toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dias Utieis'),
                        Text(header['DIAS_UTEIS'].toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dias Decorridos'),
                        Text(header['DIAS_DECORRIDOS'].toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dias Restantes'),
                        Text(header['DIAS_RESTANTES'].toString())
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: itens.length,
            itemBuilder: (context, index) {
              final item = itens[index];

              return TileMetaItem(item: item);
            },
          ),
        ],
      ),
    );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas'),
      ),
      drawer: const CustomDrawer(),
      // backgroundColor: Colors.grey[200],
      body: isLoading ? const ContainerLoading() : list,
    );
  }

}
