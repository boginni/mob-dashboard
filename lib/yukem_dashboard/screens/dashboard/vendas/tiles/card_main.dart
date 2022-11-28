import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../sdk/models/configuracao/app_theme.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {Key? key,
      required this.titulo,
      this.valor = '',
      this.width,
      required this.icon})
      : super(key: key);

  final String titulo;
  final String? valor;
  final double? width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 250,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            theme.colorTheme.primaryColor,
            theme.colorTheme.darken(theme.colorTheme.primaryColor, .2)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(1, 1.2),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  titulo,
                  style: theme.textTheme
                      .title3(color: theme.colorTheme.secondaryColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon,
                    size: 64,
                    color: theme.colorTheme.primaryColorBackground,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: valor == null
                              ? const CircularProgressIndicator()
                              : Text(
                                  '$valor',
                                  style: theme.textTheme.subTitle(
                                      color: theme.colorTheme.secondaryColor),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // return Card(
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
    //     child: ,
    //   ),
    // );
  }
}
