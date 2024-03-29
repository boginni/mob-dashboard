import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({
    Key? key,
    this.title,
    required this.child,
    this.width,
    this.height,
    this.expanded = false,
  }) : super(key: key);

  final Widget? title;
  final Widget child;
  final double? width;
  final double? height;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final chart = Padding(
      padding: EdgeInsets.all(8),
      child: child,
    );

    return Container(
      margin: EdgeInsets.all(2),
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorTheme.secondaryColor,
            theme.colorTheme.lighten(theme.colorTheme.primaryColor, 0.3)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              color: Colors.black,
              spreadRadius: 0,
              blurRadius: .5,
              offset: Offset(.5, .6))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: title!,
            ),
          expanded ? Expanded(child: chart) : chart
        ],
      ),
    );
  }
}

class ChartContainerTitle extends StatelessWidget {
  const ChartContainerTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      child: Text(
        title ?? '',
        style: theme.textTheme.title(color: theme.colorTheme.primaryColor),
      ),
    );
  }
}
