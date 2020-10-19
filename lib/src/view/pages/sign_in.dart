import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/controller/sign_in_controller.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/pages/home_page.dart';
import 'package:intertwined/src/view/widgets/loading_banner.dart';
import 'package:intertwined/src/view/widgets/tapable_circle_avatar.dart';
import 'package:intertwined/src/view/widgets/text_divider.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validators;

class SignIn extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.lavendarBlush,
      body: ChangeNotifierProvider(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _SignInPageTitle(),
              _SignInAuthProviders(),
              TextDivider(text: 'OR'),
              Text('Sign In using your email and password!'),
              _SignInForm(),
              _SignUpMessage(),
              const SizedBox(height: 24)
            ],
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
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 6, bottom: 24),
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

class _SignInAuthProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final signInController = Provider.of<SignInController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TapableCircleAvatar(
          child: Image.asset(
            Assets.logos.google,
            height: 40,
            width: 40,
          ),
          onTap: () {
            signInController.setLoading(true);
            FocusScope.of(context).unfocus();

            authService.signInWithGoogle().then((_) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            }, onError: (e) {
              signInController.setLoading(false);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(e),
              ));
            });
          },
        ),
        TapableCircleAvatar(
          child: Image.asset(
            Assets.logos.github,
            height: 40,
            width: 40,
          ),
          onTap: () {
            signInController.setLoading(true);
            FocusScope.of(context).unfocus();

            authService.signInWithGitHub(context).then((_) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            }, onError: (e) {
              signInController.setLoading(false);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(e),
              ));
            });
          },
        ),
      ],
    );
  }
}

class _SignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final signInController = Provider.of<SignInController>(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
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
                filled: true,
                fillColor: Colors.white,
                labelText: 'Email address',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              validator: (val) {
                return null;
              },
              onSaved: signInController.setPassword,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Colors.white,
                labelText: 'Password',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  print('forgot password');
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
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 56)),
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
                    Scaffold.of(context).showSnackBar(SnackBar(
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
                  print('SignUp');
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


