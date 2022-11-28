import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_connection.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_user.dart';

import 'dashboard_foundation.dart';
import 'screens/login/tela_login.dart';

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
  bool onLoading = true;

  void logout() {
    onLogin = true;
    user.logout(connection);
    performHotRestart();
  }

  AppTheme theme = AppTheme();
  late AppUser user;
  late AppConnection connection = AppConnection();

  void init() async {
    try {
      user = AppUser.restore();
      final res = await user.validate(connection);
      setState(() {
        onLoading = false;
        if (res) {
          onLogin = false;
        }
      });
    } catch (e) {
      setState(() {
        user = AppUser();
        onLogin = true;
        onLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    onLogin = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
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
            return user;
          },
        ),
        Provider<AppConnection>(
          create: (context) {
            return connection;
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
                  onLoading: onLoading,
                )
              : const Dashboard(),
        ),
      ),
    );
  }
}
