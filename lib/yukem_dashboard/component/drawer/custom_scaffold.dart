import 'package:flutter/material.dart';

import '../../../sdk/models/configuracao/app_theme.dart';
import '../container_loading.dart';
import 'custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.loading = false,
    required this.appBar,
    required this.body,
    this.minWidth,
  }) : super(key: key);

  final bool loading;
  final Widget body;
  final AppBar appBar;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    final size = AppSize.of(context);
    bool showDrawer = size.width > 1500;
    // bool showDrawer = false;

    return Scaffold(
      appBar: appBar,
      drawer: showDrawer ? null : const CustomDrawer(),
      body: (minWidth == null || size.width > minWidth!)
          ? SideDrawer(
              loading: loading,
              child: Padding(
                padding: AppTheme.of(context).telaPadding,
                child: body,
              ),
              showDrawer: showDrawer,
            )
          : Text('Use Uma resolução Maior para acessar essa tela'),
    );
  }
}

class SideDrawer extends StatelessWidget {
  const SideDrawer(
      {Key? key,
      required this.child,
      this.loading = false,
      this.showDrawer = true})
      : super(key: key);

  final bool loading;
  final bool showDrawer;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final body = loading ? const ContainerLoading() : child;

    return showDrawer
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDrawer(),
              Expanded(
                child: body,
              ),
            ],
          )
        : body;
  }
}
