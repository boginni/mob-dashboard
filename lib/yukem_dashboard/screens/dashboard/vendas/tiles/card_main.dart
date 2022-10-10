import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../sdk/models/configuracao/app_theme.dart';

class MainCardTile extends StatelessWidget {
  const MainCardTile({Key? key, required this.titulo, this.valor = ''})
      : super(key: key);

  final String titulo;
  final String? valor;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final size = AppSize.of(context);

    final cardPadding = EdgeInsets.symmetric(horizontal: size.poor? 8 : 16, vertical: 22);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.mobile ? 4 : 8),
      child: Container(
        width: size.bigScreen ? 380 : size.smallScreen ? size.poor ?300 : 380 : 300,
        height: 120,
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
                offset: Offset(1, 1.2))
          ],
        ),
        child: Padding(
          padding: cardPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 64,
                    color: theme.colorTheme.primaryColorBackground,
                  ),
                  // Icon(Icons.arrow_drop_down_sharp, size: 32,),
                  // Text(
                  //   '11.73',
                  //   style: theme.textTheme
                  //       .body(color: theme.colorTheme.secondaryColor),
                  // ),
                  // Text(
                  //   '%',
                  //   style: theme.textTheme
                  //       .subTitle2(color: theme.colorTheme.secondaryColor),
                  // ),
                ],
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: theme.textTheme
                        .title3(color: theme.colorTheme.secondaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('R\$: $valor',
                        style: theme.textTheme
                            .subTitle(color: theme.colorTheme.secondaryColor)),
                  ),
                  Divider(
                    color: theme.colorTheme.secondaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   titulo,
                      //   style: theme.textTheme
                      //       .body(color: theme.colorTheme.secondaryColor),
                      // ),
                      // Text('R\$: $valor',
                      //     style: theme.textTheme.subTitle2(
                      //         color: theme.colorTheme.secondaryColor))
                    ],
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
