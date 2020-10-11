import 'package:flutter/material.dart';
import 'package:intertwined/src/controller/login_controller.dart';
import 'package:intertwined/src/view/pages/home_page.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Material(
      child: Center(
        child: FlatButton(
          child:
               Text('Sign In'),
          onPressed:  () {
                  authService.signIn('email@email.com', 'password').then((value) =>
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage())));
                },
        ),
      ),
    );
  }
}
