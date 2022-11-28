import 'item.dart';

class Pessoa extends Item {
  final int id;
  final String nome;

  Pessoa(this.id, this.nome) : super(id, nome);

// factory Produto.parse(List<dynamic> item) {
//   return Produto(item[0], item[1], item[2] == 'T');
// }

// static Future<List<Produto>> getData(BuildContext context,
//     {required bool mobile, String? filter}) async {
//   final app = AppConnection.of(context);
//
//   final rows = await app.getBuffetResult(ServerRoutes.util_produto_list,
//       body: {'mobile': mobile, 'filter': filter ?? ''}, headers: {});
//
//   final List<Produto> itens = [];
//   for (final item in rows) {
//     itens.add(Produto.parse(item));
//   }
//
//   return itens;
// }

}
