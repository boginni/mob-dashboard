import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

class ThemedButton extends StatelessWidget {
  const ThemedButton(
      {Key? key, this.onPressed, required this.text, this.onSelected = true})
      : super(key: key);

  final String text;
  final void Function()? onPressed;
  final bool onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: SizedBox(
        // width: double.infinity,
        height: 40,
        child: TextButton(
          style: onSelected ? theme.buttonStyle : theme.buttonStyle2,
          child: Text(text,
              style: onSelected
                  ? theme.textTheme.subTitle2()
                  : theme.textTheme
                      .subTitle2(color: theme.colorTheme.primaryColor)),
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            }
          },
        ),
      ),
    );
  }
}
