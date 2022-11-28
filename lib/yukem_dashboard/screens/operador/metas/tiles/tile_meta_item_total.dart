import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../sdk/models/configuracao/app_theme.dart';
import '../moddels/meta_item_total.dart';

class TileMetaItemTotal extends StatelessWidget {
  const TileMetaItemTotal(
      {Key? key,
      required this.item,
      this.editable = false,
      required this.onSelected,
      this.onPressed})
      : super(key: key);

  final MetaItemTotal item;
  final bool editable;
  final void Function()? onPressed;
  final bool onSelected;

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
              child: Container(
                color: onSelected
                    ? theme.colorTheme.secondaryColorBackground
                    : null,
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
              children: [
                Text('Faturado'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$',
                      style: theme.textTheme.detail(),
                    ),
                    Text(
                      round(item.valorAtual).replaceFirst('.', ','),
                      style: theme.textTheme.title3(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),

            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(flex: 1, child: Text('Meta')),
            //         Expanded(flex: 1, child: Text('Atual')),
            //         Expanded(flex: 1, child: Text('Média')),
            //         Expanded(flex: 1, child: Text('Tendencia')),
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(flex: 1, child: Text(item.qtdMeta.toString())),
            //         Expanded(flex: 1, child: Text(item.qtdAtual.toString())),
            //         Expanded(flex: 1, child: Text(item.qtdMetaDia.toString())),
            //         Expanded(
            //           flex: 1,
            //           child: Text(
            //               '${item.qtdTendencia} ( ${item.pctTendencia}% )'),
            //         ),
            //       ],
            //     )
            //   ],
            // ),

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
