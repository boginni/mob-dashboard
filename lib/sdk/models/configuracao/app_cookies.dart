import 'dart:html';

class AppCookies {
  late Map<String, String> cookieMap;

  AppCookies();

  factory AppCookies.restore() {
    final c = AppCookies();
    c.updateCookies();
    return c;
  }

  updateCookies() {
    final cookie = document.cookie!;

    try {
      final entity = cookie.split("; ").map((item) {
        final split = item.split("=");
        return MapEntry(split[0], split[1]);
      });

      cookieMap = Map.fromEntries(entity);
    } catch (e) {
      cookieMap = {};
    }
  }

  String? get(String key) {
    return cookieMap[key];
  }

  set(Map<String, dynamic> map) {
    map.forEach((key, value) {
      document.cookie = "$key=${value.toString()}";
    });

    updateCookies();
  }
}
