import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/controller/sign_up_controller.dart';
import 'package:intertwined/src/view/pages/auth/sign_up/display_name_page.dart';
import 'package:intertwined/src/view/pages/auth/sign_up/email_password_page.dart';
import 'package:intertwined/src/view/pages/auth/sign_up/setting_up_page.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpController(PageController(initialPage: 0)),
      builder: (BuildContext context, _) {
        return Consumer<SignUpController>(
          builder: (BuildContext context, signUpController, _) {
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: BackButton(
                      color: MainColors.richBlackFogra,
                    ),
                    flexibleSpace: SafeArea(
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: signUpController.progressPercentage,
                      ),
                    ),
                  ),
                  backgroundColor: MainColors.lavendarBlush,
                  body: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (ind) =>
                        signUpController.setProgressPercentage((ind + 1) / 3),
                    controller: signUpController.pageController,
                    children: [
                      DisplayNamePage(),
                      EmailPasswordPage(),
                      SettingUpPage(),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
