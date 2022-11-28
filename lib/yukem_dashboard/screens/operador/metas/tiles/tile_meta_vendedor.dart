import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

import '../moddels/meta_vendedor.dart';

class TileMetaVendedor extends StatelessWidget {
  const TileMetaVendedor(
      {Key? key,
      required this.item,
      required this.onPressed,
      this.onSelected = false})
      : super(key: key);

  final MetaVendedor item;
  final void Function() onPressed;

  final bool onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: onSelected
              ? AppTheme.of(context).colorTheme.secondaryColorBackground
              : null,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Text(
                '${item.nomeProduto}',
                style: AppTheme.of(context).textTheme.subTitle(),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '(${item.qtdMetas})',
                style: AppTheme.of(context).textTheme.title2(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
