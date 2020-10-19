import 'package:flutter/material.dart';

class SignUpController with ChangeNotifier {
  final PageController pageController;
  SignUpController(this.pageController);

  bool isLoading = false;
  String displayName;
  String email;
  String password;
  double progressPercentage = 0;

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
}
