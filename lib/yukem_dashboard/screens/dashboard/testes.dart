import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/vendas/chart/abc_clientes.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/vendas/chart/abc_produtos.dart';

import '../../component/drawer/custom_drawer.dart';

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
          const ListABCProdutos(),
          const ListABCClientes(),
        ],
      ),
    );
  }
}