import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../component/drawer/custom_scaffold.dart';

class TelaFaturamento extends StatefulWidget {
  const TelaFaturamento({Key? key}) : super(key: key);

  @override
  State<TelaFaturamento> createState() => _TelaFaturamentoState();
}

class _TelaFaturamentoState extends State<TelaFaturamento> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Faturamento'),
      ),
      body: Container(),
    );
  }
}
