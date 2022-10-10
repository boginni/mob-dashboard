import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

class ContainerLoading extends StatelessWidget {
  const ContainerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Carregando Dados',
                style: AppTheme.of(context).textTheme.title2(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerAfterLoading extends StatelessWidget {
  const ContainerAfterLoading(
      {Key? key, required this.onLoading, required this.child})
      : super(key: key);

  final bool onLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return onLoading ? const ContainerLoading() : child;
  }
}
