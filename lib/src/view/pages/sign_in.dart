import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/pages/home_page.dart';
import 'package:intertwined/src/view/widgets/tapable_circle_avatar.dart';
import 'package:intertwined/src/view/widgets/text_divider.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validators;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<FormState>();
  bool isLoading = false;
  String email;
  String password;
  void setLoading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MainColors.lavendarBlush,
      body: Builder(builder: (context) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildTitle(context),
                  buildLoginProvidersRow(context, authService),
                  TextDivider(
                    text: 'OR',
                  ),
                  Text('Sign In using your email and password!'),
                  buildForm(context, authService),
                  buildSignUpText(context, authService),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
            if (isLoading) buildLoadingBanner(context),
          ],
        );
      }),
    );
  }

  Widget buildTitle(BuildContext context) => Padding(
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

  Widget buildLoginProvidersRow(
          BuildContext context, AuthService authService) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TapableCircleAvatar(
            child: Image.asset(
              Assets.googleLogo,
              height: 40,
              width: 40,
            ),
            onTap: () {
              setLoading(true);
              FocusScope.of(context).unfocus();

              authService.signInWithGoogle().then((_) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              }, onError: (e) {
                setLoading(false);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(e),
                ));
              });
            },
          ),
          TapableCircleAvatar(
            child: Image.asset(
              Assets.githubLogo,
              height: 40,
              width: 40,
            ),
            onTap: () {
              setLoading(true);
              FocusScope.of(context).unfocus();

              authService.signInWithGitHub(context).then((_) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              }, onError: (e) {
                setLoading(false);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(e),
                ));
              });
            },
          ),
        ],
      );

  Widget buildForm(BuildContext context, AuthService authService) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onSaved: (value) => email = value,
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
                onSaved: (value) => password = value,
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
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 2, 56)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setLoading(true);
                    FocusScope.of(context).unfocus();
                    _formKey.currentState.save();

                    authService.signIn(email, password).then((_) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                    }, onError: (e) {
                      setLoading(false);
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

  RichText buildSignUpText(BuildContext context, AuthService authService) =>
      RichText(
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
  Widget buildLoadingBanner(BuildContext context) => SizedBox.expand(
        child: Material(
          color: Colors.black26,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
