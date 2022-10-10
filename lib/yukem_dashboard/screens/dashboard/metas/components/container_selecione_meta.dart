import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

class ContainerSelecioneMeta extends StatelessWidget {
  const ContainerSelecioneMeta({Key? key, required this.condition, this.child})
      : super(key: key);

  final bool condition;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return condition && child != null
        ? child!
        : Center(
          child: Card(
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Selecione uma meta',
                  style: AppTheme.of(context).textTheme.title(),
                ),
              ),
            ),
        );
  }
}
