// ignore_for_file: dead_code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/yukem_dashboard/component/container_loading.dart';

import '../../app_foundation.dart';
import 'drawer_tile.dart';

int curId = 0;

int getNextId() {
  return curId++;
}

class CustomDrawer extends StatefulWidget {
  // final bool Function()? onChange = (){ return true;};

  const CustomDrawer({Key? key}) : super(key: key); //this.onChanges

  @override
  State<StatefulWidget> createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool logo = true;
    int i = 0;

    return Drawer(
      child: ListView(
        children: <Widget>[
          /// Implementar sistema pra mostrar logo customizada
          if (logo)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Controlador de Metas',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  Text('Yukem Vendas',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left),
                  Text(Application.versao,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left),
                ],
              ),
            ),
          if (logo) Divider(color: Colors.grey[800]),
          // DrawerTile(
          //   iconData: Icons.home,
          //   title: 'TESTE',
          //   page: i++,
          // ),

          DrawerTile(
            iconData: Icons.account_tree_outlined,
            title: 'Testes',
            page: i++,
          ),

          DrawerExpansionTile(
            iconData: CupertinoIcons.chart_bar_circle,
            title: 'Dashboard',
            id: 0,
            children: [
              DrawerTile(
                iconData: Icons.monetization_on_outlined,
                title: 'Vendas',
                page: i++,
              ),
              DrawerTile(
                iconData: CupertinoIcons.cube_box,
                title: 'Fluxo Caixa',
                page: i++,
              ),
              // DrawerTile(
              //   iconData: CupertinoIcons.cube_box,
              //   title: 'Contas',
              //   page: 0,
              // ),
              // DrawerTile(
              //   iconData: Icons.show_chart,
              //   title: 'Vendedores',
              //   page: 0,
              // ),
              // DrawerTile(
              //   iconData: Icons.monetization_on_outlined,
              //   title: 'Projeções',
              //   page: 0,
              // ),
            ],
          ),

          DrawerTile(
            iconData: Icons.area_chart,
            title: 'Metas',
            page: i++,
          ),

          //
          // const DrawerExpansionTile(
          //   iconData: CupertinoIcons.person_alt,
          //   title: 'Vendedor',
          //   id: 1,
          //   children: [
          //     DrawerTile(
          //       iconData: Icons.monetization_on_outlined,
          //       title: 'Comissão',
          //       page: 1,
          //     ),
          //     DrawerTile(
          //       iconData: CupertinoIcons.cube_box,
          //       title: 'Crítica',
          //       page: 2,
          //     ),
          //     DrawerTile(
          //       iconData: Icons.show_chart,
          //       title: 'Metas',
          //       page: 3,
          //     ),
          //     DrawerTile(
          //       iconData: Icons.monetization_on_outlined,
          //       title: 'Faturamento',
          //       page: 4,
          //     ),
          //   ],
          // ),
          //
          // DrawerExpansionTile(
          //   iconData: CupertinoIcons.building_2_fill,
          //   title: 'Operador',
          //   id: 2,
          //   children: [
          //     DrawerTile(
          //       iconData: Icons.monetization_on_outlined,
          //       title: 'Produtos',
          //       page: 0,
          //     ),
          //     DrawerTile(
          //       iconData: Icons.show_chart,
          //       title: 'Metas',
          //       page: 0,
          //     ),
          //   ],
          // ),

          // const DrawerExpansionTile(
          //   iconData: Icons.add_chart,
          //   title: 'Gráficos',
          //   id: 1,
          //   children: [
          //     DrawerTile(
          //       iconData: Icons.monetization_on_outlined,
          //       title: 'Vendas',
          //       page: 0,
          //     ),
          //     DrawerTile(
          //       iconData: CupertinoIcons.cube_box,
          //       title: 'Contas',
          //       page: 0,
          //     ),
          //   ],
          // ),

          Divider(color: Colors.grey[800]),
          DrawerTile(
            iconData: Icons.settings,
            title: 'Configurações',
            page: i++,
          ),
          Divider(color: Colors.grey[800]),
          DrawerTile(
            iconData: Icons.logout,
            title: 'Sair',
            page: 999,
            onPressed: () => Application.logout(context),
          ),
        ],
      ),
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
    // bool showDrawer = size.width > 1500;
    bool showDrawer = false;

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

bool showConsultas = false;
