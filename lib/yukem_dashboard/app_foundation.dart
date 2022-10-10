import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_connection.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_user.dart';

import '../sdk/screens/tela_login.dart';
import 'dashboard_foundation.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  static const String versao = '0.0.1';

  @override
  State<StatefulWidget> createState() => _ApplicationState();

  static logout(BuildContext context) {
    final _ApplicationState? state =
        context.findAncestorStateOfType<_ApplicationState>();

    if (state != null) {
      state.logout();
    }
  }
}

class _ApplicationState extends State<Application> {
  Key mainApplicationKey = UniqueKey();

  void performHotRestart() {
    setState(() {
      mainApplicationKey = UniqueKey();
    });
  }

  late bool onLogin;

  void logout() {
    onLogin = true;
    performHotRestart();
  }

  AppTheme theme = AppTheme();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLogin = false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppTheme>(
          create: (context) {
            return theme;
          },
        ),
        Provider<AppUser>(
          create: (context) {
            return AppUser();
          },
        ),
        Provider<AppConnection>(
          create: (context) {
            return AppConnection();
          },
        ),
      ],
      child: Container(
        key: mainApplicationKey,
        child: MaterialApp(
          home: onLogin
              ? TelaLogin(
                  subimit: () {
                    setState(
                      () {
                        onLogin = false;
                      },
                    );
                  },
                )
              : const Dashboard(),
        ),
      ),
    );
  }
}
