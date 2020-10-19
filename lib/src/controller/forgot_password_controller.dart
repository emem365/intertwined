import 'package:flutter/material.dart';

class ForgotPasswordController with ChangeNotifier {
  bool isLoading = false;
  String email;

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void setEmail(String str) {
    email = str;
  }
}
