import 'package:flutter/material.dart';
import 'package:intertwined/src/controller/login_controller.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget loggedInScreen;
  final Widget loggedOutScreen;
  AuthWrapper(this.loggedInScreen, this.loggedOutScreen);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).authState;
    if (user == AuthState.logged_in)
      return loggedInScreen;
    else
      return loggedOutScreen;
  }
}