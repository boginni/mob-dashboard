import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/metas/moddels/meta_vendedor.dart';

import '../../../../../sdk/common/formatter/date_time_formatter.dart';
import '../moddels/meta.dart';

class ContainerMetaHeader extends StatelessWidget {
  const ContainerMetaHeader({Key? key, required this.meta, this.vendedor})
      : super(key: key);

  final Meta meta;
  final MetaVendedor? vendedor;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      meta.nome,
                      style: theme.textTheme.title(),
                    ),
                    // Text(
                    //     '${DateFormatter.normalData.format(DateTime.parse(header['DATA_INICIO']))} - ${DateFormatter.normalData.format(DateTime.parse(header['DATA_FIM']))}')
                    Text(
                      '${DateFormatter.normalData.format(meta.dataInicio)} - ${DateFormatter.normalData.format(meta.dataFim)}',
                      style: theme.textTheme.title2(),
                    )
                  ],
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Text('Vendedor'), Text(header.nomeMeta)],
            // ),
            if (vendedor != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vendedor',
                    style: theme.textTheme.subTitle(),
                  ),
                  Text(vendedor!.nomeProduto,
                      style: theme.textTheme.subTitle()),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Dias Úteis'), Text(meta.diasUteis.toString())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dias Decorridos'),
                Text(meta.diasDecorridos.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dias Restantes'),
                Text(meta.diasRestantes.toString())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
