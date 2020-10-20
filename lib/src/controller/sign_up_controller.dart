import 'package:flutter/material.dart';

class SignUpController with ChangeNotifier {
  final PageController pageController;
  SignUpController(this.pageController);

  bool isLoading = false;
  bool signUpSuccessful;
  String displayName;
  String email;
  String password;
  String rePassword;
  double progressPercentage = 0.33;

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void setProgressPercentage(double val) {
    progressPercentage = val;
    notifyListeners();
  }

  void setDisplayName(String str) {
    displayName = str;
  }

  void setEmail(String str) {
    email = str;
  }

  void setPassword(String str) {
    password = str;
  }

  void setRePassword(String str) {
    rePassword = str;
  }

  void setSignUpSuccessful(bool val) {
    signUpSuccessful = val;
  }
}
