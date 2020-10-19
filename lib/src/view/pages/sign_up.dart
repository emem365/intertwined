import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/controller/sign_in_controller.dart';
import 'package:intertwined/src/controller/sign_up_controller.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/pages/forgot_password.dart';
import 'package:intertwined/src/view/pages/home_page.dart';
import 'package:intertwined/src/view/widgets/loading_banner.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validators;

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
                    onPageChanged: (ind) =>
                        signUpController.setProgressPercentage((ind+1) / 4),
                    controller: signUpController.pageController,
                    children: [
                      Material(
                        child: Center(
                            child: TextButton(
                          child: Text('Page1'),
                          onPressed: () {signUpController.pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn);},
                        )),
                      ),
                      Material(
                        child: Center(
                            child: TextButton(
                          child: Text('Page2'),
                          onPressed: () {
                            signUpController.pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          },
                        )),
                      ),
                      Material(
                        child: Center(
                            child: TextButton(
                          child: Text('Page3'),
                          onPressed: () {
                            signUpController.pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          },
                        )),
                      ),
                      Material(
                        child: Center(
                            child: TextButton(
                          child: Text('Page4'),
                          onPressed: () {
                            signUpController.pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          },
                        )),
                      ),
                    ],
                  ),
                  //  SingleChildScrollView(
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       // _SignUpForm(),
                  //     ],
                  //   ),
                  // ),
                ),
                if (signUpController.isLoading) LoadingBanner(),
              ],
            );
          },
        );
      },
    );
  }
}

class _SignUpForm extends StatelessWidget {
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
