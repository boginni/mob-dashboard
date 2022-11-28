import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

import 'yukem_dashboard/app_foundation.dart';

void main() async {
  Intl.systemLocale = await findSystemLocale();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/intl_browser.dart';
//
// void main() async{
//
//   Intl.systemLocale = await findSystemLocale();
//
//   runApp(
//     MaterialApp(
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate
//       ],
//       supportedLocales: [const Locale('pt', 'BR')],
//       home: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<MyApp> {
//   String _value = '';
//
//   Future _selectDate() async {
//     DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2021),
//         lastDate: DateTime(2023));
//
//     if (picked != null) {
//       setState(() {
//         _value = DateFormat.yMMMMEEEEd().format(picked);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Exemplo localização'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(32.0),
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Text(_value),
//               ElevatedButton(
//                 onPressed: _selectDate,
//                 child: Text('CLIQUE'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
