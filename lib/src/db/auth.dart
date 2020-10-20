import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:intertwined/src/constants/auth_providers_secret.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  GoogleSignIn googleSignIn;

  AuthService(this._firebaseAuth) {
    this.googleSignIn = GoogleSignIn();
  }

  Stream<User> get authStateStream => _firebaseAuth.authStateChanges();

  AuthState get authState {
    if (_firebaseAuth.currentUser == null) {
      return AuthState.logged_out;
    } else {
      return AuthState.logged_in;
    }
  }

  User get currentUser => _firebaseAuth.currentUser;

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }

  Future<String> signUp(
      String email, String password, String displayName) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult?.user != null) {
        assert(!authResult.user.isAnonymous);
        setDisplayName(displayName).catchError((e) {
          throw Exception(e.toString());
        });
        return authResult.user.uid;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (authResult?.user != null) {
        assert(!authResult.user.isAnonymous);
        return authResult.user.uid;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }

  Future<String> signInWithGitHub(BuildContext context) async {
    try {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: AuthProvidersSecret.gitHubClientId,
        clientSecret: AuthProvidersSecret.gitHubClientSecret,
        redirectUrl: AuthProvidersSecret.gitHubRedirectUrl,
        scope: 'read:user',
      );

      final result = await gitHubSignIn.signIn(context);
      if (result.status == GitHubSignInResultStatus.ok &&
          result?.token != null) {
        final AuthCredential gitHubAuthCredential =
            GithubAuthProvider.credential(result.token);
        print(gitHubAuthCredential);
        final UserCredential authResult =
            await _firebaseAuth.signInWithCredential(gitHubAuthCredential);

        if (authResult?.user != null) {
          assert(!authResult.user.isAnonymous);
          return authResult.user.uid;
        } else {
          throw Exception('Something went wrong');
        }
      } else {
        return Future.error(result.errorMessage);
      }
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(authCredential);

      if (authResult?.user != null) {
        assert(!authResult.user.isAnonymous);
        return authResult.user.uid;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();

      if (_firebaseAuth.currentUser != null) {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }

  Future<void> setDisplayName(String name) async {
    try {
      await _firebaseAuth.currentUser.updateProfile(displayName: name);
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }

  Future<void> setDisplayPicture(String url) async {
    try {
      await _firebaseAuth.currentUser.updateProfile(photoURL: url);
    } catch (e) {
      if (e.message == null || e.message == '')
        return Future.error('Something went wrong. Please try again');
      return Future.error(e.message);
    }
  }
}

enum AuthState {
  logged_in,
  logged_out,
}
