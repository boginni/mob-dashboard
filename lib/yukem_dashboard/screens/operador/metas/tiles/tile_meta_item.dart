import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../sdk/models/configuracao/app_theme.dart';
import '../components/buttons.dart';
import '../moddels/meta_item.dart';

class TileMetaItem extends StatelessWidget {
  const TileMetaItem(
      {Key? key,
      required this.item,
      this.editable = false,
      this.onPressed,
      this.onEdit,
      this.onRemove})
      : super(key: key);

  final MetaItem item;
  final bool editable;
  final void Function()? onPressed;
  final void Function()? onEdit;
  final void Function()? onRemove;

  execute(Function? f) {
    if (f != null) {
      f();
    }
  }

  @override
  Widget build(BuildContext context) {
    String round(dynamic x) {
      return double.parse(x.toString()).toStringAsFixed(2);
    }

    final theme = AppTheme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: 16,
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
                          style: theme.textTheme.subTitle(color: Colors.green),
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
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
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
                    children: [
                      Text('Meta do dia'),
                      Text(item.qtdMetaDia.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tendencia'),
                      Text('${item.qtdTendencia} ( ${item.pctTendencia}% )')
                    ],
                  ),
                  if (editable)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: RemoveButton(onPressed: onRemove, popUp: true,),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          Expanded(
                            child: EditButton(
                              onPressed: onEdit,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
