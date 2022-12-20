import 'package:flutter/material.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/drawer/custom_scaffold.dart';

class TelaCaixa extends StatefulWidget {
  const TelaCaixa({Key? key}) : super(key: key);

  @override
  State<TelaCaixa> createState() => _TelaCaixaState();
}

class _TelaCaixaState extends State<TelaCaixa> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(title: Text('Caixa')),
      body: Container(),
    );
  }
}
