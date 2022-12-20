import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_cookies.dart';

import 'app_connection.dart';

class AppUser {
  String user = '';
  String pass = '';
  int? userID;
  String userUUID = '';
  bool onValid = false;

  save({bool passSave = false}) {
    final map = {
      "user": user,
      "user_id": userID,
      "user_uuid": userUUID,
      "pass": passSave ? pass : ''
    };

    AppCookies().set(map);
  }

  AppUser();

  factory AppUser.of(BuildContext context) {
    return context.read<AppUser>();
  }

  factory AppUser.restore() {
    final u = AppUser();
    final c = AppCookies.restore();

    u.user = c.get('user')!;
    u.pass = c.get('pass')!;
    u.userID = int.tryParse(c.get('user_id') ?? '')!;
    u.userUUID = c.get('user_uuid')!;
    return u;
  }

  toHeaders() {
    return {
      'user_id': '$userID',
      'user_uuid': userUUID,
    };
  }

  Future<bool> validate(AppConnection app) async {
    final h = toHeaders();
    final response = await app.serverPost('/sys/validate/', headers: h);

    if (response.statusCode == 422) {
      return false;
    }

    if (response.statusCode == 200) {
      onValid = const JsonDecoder().convert(response.body) as bool;
      return onValid;
    }

    throw Exception('Resposta inválida');
  }

  Future login(BuildContext context) async {
    final app = AppConnection.of(context);

    final response = await app.serverPost(
      '/sys/login/',
      body: {"user": user, "pass": pass},
    );

    if (response.statusCode == 200) {
      final b = const JsonDecoder().convert(response.body);
      userID = b['user_id'];
      userUUID = b['user_uuid'];
      onValid = true;
    }
  }

  Future logout(AppConnection app) async {
    // final app = AppConnection.of(context);

    // return await app.serverPost(
    //   '/dash/web/main/pie/rotaCidade',
    //   body: {"idRota": idRota},
    //   headers: {},
    // ).then((response) {
    //   final value = const JsonDecoder().convert(response.body);
    // });

    userUUID = '';
    userID = null;
    onValid = false;
    save();
  }
}
