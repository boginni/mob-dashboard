import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../component/chart_container.dart';
import '../../../../models/data_ojects/vendedor/critica_vendedor.dart';

class VendasCidade extends StatelessWidget {
  const VendasCidade(
      {Key? key, required this.chartData, required this.callback})
      : super(key: key);

  final List<CriticaVendedor> chartData;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return ChartContainer(
        title: ChartContainerTitle('Series do Mês'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfCircularChart(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              series: <CircularSeries>[
                // Render pie chart
                PieSeries<CriticaVendedor, String>(
                  radius: '100%',
                  dataSource: chartData,
                  // pointColorMapper: (CriticaVendedor data, _) => data.color,
                  xValueMapper: (CriticaVendedor data, _) => data.nomeproduto,
                  yValueMapper: (CriticaVendedor data, _) => data.totalfinal,
                  dataLabelMapper: (CriticaVendedor data, _) =>
                      data.nomeproduto,
                  pointColorMapper: (CriticaVendedor data, _) => data.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                    // Avoid labels intersection
                    labelIntersectAction: LabelIntersectAction.shift,
                    labelPosition: ChartDataLabelPosition.outside,
                    connectorLineSettings: ConnectorLineSettings(
                        type: ConnectorType.curve, length: '25%'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                itemCount: chartData.length,
                itemBuilder: (context, index) {
                  final item = chartData[index];

                  return Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: item.color,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(item.nomeproduto)
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}
