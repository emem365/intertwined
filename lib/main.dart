import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';

import 'src/view/pages/home_page.dart';

Future<void> main() async{
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intertwined',
      theme: AppThemes.lightTheme,
      home: HomePage(),
    );
  }
}
