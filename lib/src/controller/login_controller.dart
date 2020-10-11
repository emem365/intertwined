import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/db/auth.dart';
export 'package:intertwined/src/db/auth.dart';

class LoginController with ChangeNotifier {
  LoginController() : _authService = AuthService(FirebaseAuth.instance) {
    //cancel this subscription on dispose
    subscription = _authService.authStateStream.listen(handleAuthStateChanges);
  }

  // Final Values
  final AuthService _authService;

  //These will change with state
  bool isLoading = true;

  
  StreamSubscription subscription;

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  AuthService get authService => _authService;
  
  AuthState get authState => _authService.authState;  

  void handleAuthStateChanges(User user) {
    setLoading(false);
  }

  @override
  void dispose(){
    subscription.cancel();
    super.dispose();
  }
}
