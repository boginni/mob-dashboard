import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/models/data_ojects/util/produto.dart';

class TileProduto extends StatelessWidget {
  const TileProduto({Key? key, required this.item, required this.onPressed})
      : super(key: key);

  final Produto item;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.cube_box,
                size: 32,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(item.id.toString(), style: AppTheme.of(context).textTheme.subTitle(),),
              const SizedBox(
                width: 8,
              ),
              Text(
                item.nome,
                style: AppTheme.of(context).textTheme.title2(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
