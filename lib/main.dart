import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/db/database.dart';
import 'package:intertwined/src/model/text_snippets.dart';
import 'package:intertwined/src/view/pages/auth/sign_in.dart';
import 'package:intertwined/src/view/pages/edit_snippet.dart';
import 'package:intertwined/src/view/widgets/auth_wrapper.dart';
import 'package:provider/provider.dart';

import 'src/view/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        Provider(
          create: (_) => DatabaseService(FirebaseFirestore.instance),
        )
      ],
      builder: (BuildContext context, _) {
        return MaterialApp(
          title: 'Intertwined',
          theme: AppThemes.lightTheme(context),
          home: AuthWrapper(HomePage(), SignIn()),
        );
      },
    );
  }
}
