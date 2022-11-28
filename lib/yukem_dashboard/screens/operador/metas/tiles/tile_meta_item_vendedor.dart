import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../sdk/models/configuracao/app_theme.dart';
import '../moddels/meta_item_vendedor.dart';

class TileMetaItemVendedor extends StatelessWidget {
  const TileMetaItemVendedor({Key? key, required this.item, this.onPressed})
      : super(key: key);

  final MetaItemVendedor item;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    String round(dynamic x) {
      return double.parse(x.toString()).toStringAsFixed(2);
    }

    final theme = AppTheme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (onPressed != null) {
                  onPressed!();
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.cube_box,
                          size: 32,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.nomeProduto}",
                                style: theme.textTheme.subTitle(),
                              ),
                              Text(
                                "${item.qtdAtual}/${item.qtdMeta}",
                                style: theme.textTheme.title2(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'R\$',
                              style: theme.textTheme.detail(),
                            ),
                            Text(
                              round(item.valorAtual).replaceFirst('.', ','),
                              style:
                                  theme.textTheme.title3(color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    LinearProgressIndicator(
                      value: item.getLinearProgressValue(),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Meta'), Text(item.qtdMeta.toString())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantidade Atual'),
                Text(item.qtdAtual.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Meta do dia'), Text(item.qtdMetaDia.toString())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tendência'),
                Text('${item.qtdTendencia} ( ${item.pctTendencia}% )')
              ],
            )
          ],
        ),
      ),
    );
  }
}
