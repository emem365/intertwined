import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/controller/sign_up_controller.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validators;

class EmailPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 800),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6, bottom: 24),
                child: Text(
                  'Set Email and Password',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w900,
                        color: MainColors.richBlackFogra,
                      ),
                ),
              ),
              _EmailPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailPasswordForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final signUpController = Provider.of<SignUpController>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: (MediaQuery.of(context).size.width > 800) ? 150 : 32),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onSaved: signUpController.setEmail,
              validator: (val) {
                if (!validators.isEmail(val)) {
                  return 'Invalid email.';
                }
                return null;
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white,
                labelText: 'Email address',
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: passwordController,
              validator: (val) {
                if (val.length < 8) return "Password too short";
                return null;
              },
              obscureText: true,
              onSaved: signUpController.setPassword,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white,
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              validator: (val) {
                if (passwordController.text != val)
                  return "Password doesnt match";
                return null;
              },
              obscureText: true,
              onSaved: signUpController.setRePassword,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white,
                labelText: 'Repeat Password',
              ),
            ),
            SizedBox(
              height: 36,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: MainColors.zomp,
                  shape: StadiumBorder(),
                  minimumSize:
                      Size(min(MediaQuery.of(context).size.width / 1.5, 250), 56)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();
                  _formKey.currentState.save();
                  signUpController.setLoading(true);
                  signUpController.pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                  Future.microtask(() => authService
                          .signUp(
                        signUpController.email,
                        signUpController.password,
                        signUpController.displayName,
                      )
                          .then((value) {
                        signUpController.setSignUpSuccessful(true);
                        signUpController.setLoading(false);
                      }, onError: (e) {
                        signUpController.setSignUpSuccessful(false);
                        signUpController.setLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e),
                        ));
                      }));
                }
              },
              child: Text(
                'SignUp',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
