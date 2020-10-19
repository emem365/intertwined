import 'package:flutter/material.dart';

class SignInController with ChangeNotifier {
  bool isLoading = false;
  String email;
  String password;

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void setEmail(String str) {
    email = str;
  }

  void setPassword(String str) {
    password = str;
  }
}
