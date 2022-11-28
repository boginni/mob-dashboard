import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/dashboard/vendas/tela_vendas.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/operador/metas/tela_metas.dart';
import 'package:yukem_dashboard/yukem_dashboard/screens/utilidades/tela_configuracoes.dart';

import '../sdk/models/configuracao/app_cookies.dart';
import '../sdk/models/configuracao/app_theme.dart';
import '../sdk/utility/page_manager.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final PageManager pageManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageManager = PageManager();
  }

  @override
  Widget build(BuildContext context) {
    Widget p(Widget child) {
      return WillPopScope(
        onWillPop: () => pageManager.onWillPop(),
        child: child,
      );
    }

    final theme = AppTheme.of(context);

    return Provider(
      create: (BuildContext context) {
        return pageManager;
      },
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt')],
        theme: ThemeData(
          primaryColor: theme.colorTheme.primaryColor,
          scaffoldBackgroundColor: theme.colorTheme.secondaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryIconTheme:
              const IconThemeData(color: Colors.black, opacity: 255),
          appBarTheme: AppBarTheme(
            elevation: 1,
            backgroundColor: theme.colorTheme.primaryColor,
            // iconTheme: const IconThemeData(color: Colors.black),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: true,
        onGenerateRoute: (initialRoute) {
          return MaterialPageRoute(
            builder: (context) {
              return WillPopScope(
                onWillPop: () => pageManager.onWillPop(),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageManager.pageController,
                  children: const <Widget>[
                    // TelaComissao(),
                    // TelaCritica(),
                    // TelaTestes(),
                    // TelaContas(),
                    // TelaRotas(),
                    TelaDashboardMain(),
                    TelaMetas(),
                    TelaConfiguracoes(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
