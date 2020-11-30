import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/controller/sign_up_controller.dart';
import 'package:intertwined/src/view/pages/home_page.dart';
import 'package:intertwined/src/view/widgets/illustration_with_title.dart';
import 'package:provider/provider.dart';

class SettingUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<SignUpController>(context);

    if (!signUpController.isLoading && signUpController.signUpSuccessful)
      Future.microtask(() => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
          ));
    else if (!signUpController.isLoading && !signUpController.signUpSuccessful)
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IllustrationWithTitle(
            (kIsWeb)
                ? Assets.illustrations.somethingWrongPng
                : Assets.illustrations.somethingWrong,
            'Something went wrong. Try again!',
          ),
          const SizedBox(height: 24),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: MainColors.fieryRose,
                shape: StadiumBorder(),
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 56)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Go Back',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white70,
                  ),
            ),
          ),
        ],
      );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IllustrationWithTitle(
          (kIsWeb)
              ? Assets.illustrations.newUserPng
              : Assets.illustrations.newUser,
          'Setting up. Please wait',
        ),
        const SizedBox(height: 24),
        CircularProgressIndicator(),
        const SizedBox(height: 24),
      ],
    );
  }
}
