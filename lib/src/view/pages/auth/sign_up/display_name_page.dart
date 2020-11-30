import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/controller/sign_up_controller.dart';
import 'package:intertwined/src/view/widgets/illustration_with_title.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validators;

class DisplayNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 800),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IllustrationWithTitle(
                (kIsWeb)
                    ? Assets.illustrations.newUserPng
                    : Assets.illustrations.newUser,
                'Sign Up',
              ),
              _DisplayNameForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DisplayNameForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
              textInputAction: TextInputAction.next,
              onSaved: signUpController.setDisplayName,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Cannot be empty';
                } else if (!validators.isAlphanumeric(val)) {
                  return 'Invalid Display Name.';
                }
                return null;
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white,
                labelText: 'Display Name',
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
                  signUpController.pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text(
                'Next',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
