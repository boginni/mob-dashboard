import 'package:flutter/material.dart';

Future<bool> mostrarCaixaConfirmacao(BuildContext context,
    {String title = "Confirmar ação?",
    String content = '',
    bool mostrarCancelar = true}) async {
  bool result = false;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (mostrarCancelar)
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          TextButton(
            child: const Text("Continuar"),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  ).then((value) {
    result = value ?? false;
  });

  return result;
}
