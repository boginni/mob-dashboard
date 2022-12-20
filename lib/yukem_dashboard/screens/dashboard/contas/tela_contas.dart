import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../component/drawer/custom_scaffold.dart';

class TelaContas extends StatefulWidget {
  const TelaContas({Key? key}) : super(key: key);

  @override
  State<TelaContas> createState() => _TelaContasState();
}

class _TelaContasState extends State<TelaContas> {

  @override
  void initState() {
    super.initState();
    // onLoading = false;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Contas'),
      ),
      loading: false,
      body: Container(
        // child: ,
      ),
    );
  }
}
