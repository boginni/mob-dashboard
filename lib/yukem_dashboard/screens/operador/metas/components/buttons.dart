import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

import '../../../../../sdk/common/components/mostrar_confirmacao.dart';

void execute(Function? f) {
  if (f != null) {
    f();
  }
}

class RemoveButton extends StatelessWidget {
  const RemoveButton(
      {Key? key,
      this.onPressed,
      this.onActive = true,
      this.text = 'Remover',
      this.popUp = false})
      : super(key: key);

  final Function? onPressed;
  final bool onActive;
  final String text;
  final bool popUp;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.red, // Text Color
      ),
      child: Text(text,
          style: onActive
              ? theme.textTheme.subTitle2()
              : theme.textTheme.subTitle()),
      onPressed: onActive
          ? () {
              if (popUp) {
                mostrarCaixaConfirmacao(context).then((value) {
                  if (value) {
                    execute(onPressed);
                  }
                });
              } else {
                execute(onPressed);
              }
            }
          : null,
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton(
      {Key? key, this.onPressed, this.onActive = true, this.text = 'Salvar'})
      : super(key: key);

  final Function? onPressed;
  final bool onActive;
  final String text;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.green, // Text Color
      ),
      child: Text(text,
          style: onActive
              ? theme.textTheme.subTitle2()
              : theme.textTheme.subTitle()),
      onPressed: onActive
          ? () {
              execute(onPressed);
            }
          : null,
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton(
      {Key? key, this.onPressed, this.onActive = true, this.text = 'Editar'})
      : super(key: key);

  final Function? onPressed;
  final bool onActive;
  final String text;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.orange, // Text Color
      ),
      child: Text(text,
          style: onActive
              ? theme.textTheme.subTitle2()
              : theme.textTheme.subTitle()),
      onPressed: onActive
          ? () {
              execute(onPressed);
            }
          : null,
    );
  }
}
