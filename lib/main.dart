import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

import 'yukem_dashboard/app_foundation.dart';

void main() async {
  Intl.systemLocale = await findSystemLocale();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}