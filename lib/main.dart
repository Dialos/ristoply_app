import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:ristoply_app/screens/splash_screen.dart';

import 'package:ristoply_app/screens/splash_screen.dart';
import 'package:ristoply_app/screens/statistiche.dart';

// import 'package:ristoply_app/widgets/statistiche/bar_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate
      ],
      //   home: BottomTab(),
      home: SplashScreen(),
    );
  }
}
