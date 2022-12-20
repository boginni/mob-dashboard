import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/chart_container.dart';

import '../../component/drawer/custom_drawer.dart';
import '../../component/drawer/custom_scaffold.dart';
import 'main/chart/abc_clientes.dart';
import 'main/chart/abc_produtos.dart';

class TelaTestes extends StatefulWidget {
  const TelaTestes({Key? key}) : super(key: key);

  @override
  State<TelaTestes> createState() => _TelaVendasState();
}

class _TelaVendasState extends State<TelaTestes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Testes'),
      ),
      body: Row(
        children: [
          ChartContainer(
            width: 300,
            height: 671,
            child: const ListABCProdutos(),
          ),
          ChartContainer(
            width: 300,
            height: 671,
            child: const ListABCClientes(),
          ),
        ],
      ),
    );
  }
}
