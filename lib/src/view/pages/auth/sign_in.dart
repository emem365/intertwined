import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/controller/sign_in_controller.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/pages/auth/forgot_password.dart';
import 'package:intertwined/src/view/pages/auth/sign_up/sign_up.dart';
import 'package:intertwined/src/view/pages/home_page/home_page.dart';
import 'package:intertwined/src/view/widgets/loading_banner.dart';
import 'package:intertwined/src/view/widgets/tapable_circle_avatar.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validators;

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(),
      builder: (BuildContext context, Widget signInScreen) {
        return Consumer<SignInController>(
          builder: (BuildContext context, signInController, _) {
            return Stack(
              children: [
                signInScreen,
                if (signInController.isLoading) LoadingBanner(),
              ],
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: MainColors.lavendarBlush,
        body: Center(
          child: SizedBox(
            width: min(MediaQuery.of(context).size.width, 800),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _SignInPageTitle(),
                  // TODO: Find implementation for web
                  //_SignInAuthProviders(),
                  //TextDivider(text: 'OR'),
                  Text('Sign In using your email and password!'),
                  _SignInForm(),
                  _SignUpMessage(),
                  const SizedBox(height: 24)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 64, bottom: 24),
      child: Text(
        'Sign In',
        style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.w900,
              color: MainColors.richBlackFogra,
            ),
      ),
    );
  }
}

// TODO: Uncomment this when you find implementation for Auth providers on Web

// class _SignInAuthProviders extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context, listen: false);
//     final signInController = Provider.of<SignInController>(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TapableCircleAvatar(
//           child: Image.asset(
//             Assets.logos.google,
//             height: 40,
//             width: 40,
//           ),
//           onTap: () {
//             signInController.setLoading(true);
//             FocusScope.of(context).unfocus();

//             authService.signInWithGoogle().then((_) {
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (BuildContext context) => HomePage()));
//             }, onError: (e) {
//               signInController.setLoading(false);
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text(e),
//               ));
//             });
//           },
//         ),
//         TapableCircleAvatar(
//           child: Image.asset(
//             Assets.logos.github,
//             height: 40,
//             width: 40,
//           ),
//           onTap: () {
//             signInController.setLoading(true);
//             FocusScope.of(context).unfocus();

//             authService.signInWithGitHub(context).then((_) {
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (BuildContext context) => HomePage()));
//             }, onError: (e) {
//               signInController.setLoading(false);
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text(e),
//               ));
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

class _SignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final signInController = Provider.of<SignInController>(context);
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
              onSaved: signInController.setEmail,
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
              validator: (val) {
                return null;
              },
              onSaved: signInController.setPassword,
              obscureText: true,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white,
                labelText: 'Password',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotPassword()));
                },
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(),
                  minimumSize: Size(
                      min(MediaQuery.of(context).size.width, 800) / 3, 56)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  signInController.setLoading(true);
                  FocusScope.of(context).unfocus();
                  _formKey.currentState.save();

                  authService
                      .signIn(signInController.email, signInController.password)
                      .then((_) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                  }, onError: (e) {
                    signInController.setLoading(false);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e),
                    ));
                  });
                }
              },
              child: Text(
                'Sign in',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w900,
                      color: MainColors.richBlackFogra,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SignUpMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.subtitle1,
        children: [
          TextSpan(
            text: 'New here? ',
          ),
          TextSpan(
              text: 'Sign up here!',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w900,
              )),
        ],
      ),
    );
  }
}
