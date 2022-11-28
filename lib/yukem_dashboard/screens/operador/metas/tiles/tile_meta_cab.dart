import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

import '../moddels/meta.dart';

class TileMetaCab extends StatelessWidget {
  const TileMetaCab(
      {Key? key,
      required this.item,
      required this.onPressed,
      this.onSelected = false})
      : super(key: key);

  final Meta item;
  final void Function() onPressed;
  final bool onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Card(
      shadowColor: Colors.black,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: onSelected? theme.colorTheme.secondaryColorBackground : null// Text Color
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nome,
                      style: theme.textTheme.title(),
                    ),
                    const Divider(),
                    Text(
                      'Vendedores ${item.qtdVendedores}',
                      style: theme.textTheme.title2(),
                    )
                  ],
                ),
              ),
              // const SizedBox(width: 28,),
              // Row(
              //   children: [
              //     Icon(CupertinoIcons.trash, size: 32,)
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
