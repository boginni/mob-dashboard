import 'dart:ui';

import '../../../../sdk/common/map_reader.dart';
import '../../../../sdk/utility/color_shquemes.dart';

class CriticaVendedor {
  String dataEmissao;
  String nomeproduto;
  int vendas;
  double quantidade;
  double totalfinal;

  final Color? color;

  CriticaVendedor(this.dataEmissao, this.nomeproduto, this.vendas,
      this.quantidade, this.totalfinal, this.color);

  factory CriticaVendedor.fromMap(Map<String, dynamic> map) {
    MapReader r = MapReader(map);

    return CriticaVendedor(
      r.value('DATA_EMISSAO'),
      r.value('PRODUTO'),
      r.integer('VENDAS'),
      r.dou('QUANTIDADE'),
      r.dou('TOTAL_FINAL'),
      ColorPallet.getColor(),
    );
  }

  static List<CriticaVendedor> getSample() {
    return [
      CriticaVendedor('xx', 'teste 0', 1, 9, 62, ColorPallet.getColor()),
      CriticaVendedor('xx', 'teste 1', 1, 9, 62, ColorPallet.getColor()),
      CriticaVendedor('xx', 'teste 4', 1, 9, 62, ColorPallet.getColor()),
      CriticaVendedor('xx', 'teste 5', 1, 9, 62, ColorPallet.getColor()),
      CriticaVendedor('xx', 'teste 6', 1, 9, 62, ColorPallet.getColor()),
      CriticaVendedor('xx', 'teste 2', 1, 9, 62, ColorPallet.getColor()),
      CriticaVendedor('xx', 'teste 7', 1, 9, 62, ColorPallet.getColor()),
    ];
  }
}
