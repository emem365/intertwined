import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/controller/forgot_password_controller.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/widgets/loading_banner.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validators;

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordController(),
      child: Scaffold(
        backgroundColor: MainColors.lavendarBlush,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: MainColors.richBlackFogra,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _ForgotPasswordImage(),
              _ForgotPasswordForm(),
            ],
          ),
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return Consumer<ForgotPasswordController>(builder:
            (BuildContext context,
                ForgotPasswordController forgotPasswordController, _) {
          return Stack(
            children: [
              child,
              if (forgotPasswordController.isLoading) LoadingBanner(),
            ],
          );
        });
      },
    );
  }
}

class _ForgotPasswordImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      // margin: EdgeInsets.only(top: 36),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              Assets.illustrations.forgotPassword,
              semanticsLabel: 'Forgot Password',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w900,
                      color: MainColors.richBlackFogra,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ForgotPasswordForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final forgotPasswordController =
        Provider.of<ForgotPasswordController>(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              textInputAction: TextInputAction.go,
              onSaved: forgotPasswordController.setEmail,
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
            SizedBox(
              height: 36,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: MainColors.zomp,
                  shape: StadiumBorder(),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 1.5, 56)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  forgotPasswordController.setLoading(true);
                  FocusScope.of(context).unfocus();
                  _formKey.currentState.save();

                  authService
                      .resetPassword(forgotPasswordController.email)
                      .then((_) {
                    Navigator.of(context).pop();
                  }, onError: (e) {
                    forgotPasswordController.setLoading(false);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(e),
                    ));
                  });
                }
              },
              child: Text(
                'Send Recovery Email',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
