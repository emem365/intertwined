import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  GoogleSignIn googleSignIn;
  
  AuthService(this._firebaseAuth){
    this.googleSignIn = GoogleSignIn();
  }
  
  Stream<User> get authStateStream => _firebaseAuth.authStateChanges();

  AuthState get authState {
    if(_firebaseAuth.currentUser == null) {
      return AuthState.logged_out;
    }
    else{
      return AuthState.logged_in;
    }
  }
  
  User get currentUser => _firebaseAuth.currentUser;

  Future<String> signUp(String email, String password) async{
    try {
      UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult?.user != null){
        assert(!authResult.user.isAnonymous);
        return authResult.user.uid;
      }
      else{
        throw FirebaseAuthException(message: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult?.user != null){
        assert(!authResult.user.isAnonymous);
        return authResult.user.uid;
      }
      else{
        throw FirebaseAuthException(message: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<String> signInWithGoogle(String email, String password) async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =  await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      final UserCredential authResult = await _firebaseAuth.signInWithCredential(authCredential);

      if (authResult?.user != null){
        assert(!authResult.user.isAnonymous);
        return authResult.user.uid;
      }
      else{
        throw FirebaseAuthException(message: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      
      if (_firebaseAuth.currentUser != null){
        throw FirebaseAuthException(message: 'Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return Future.error(e);
    }    
  }

  Future<void> setDisplayName(String name) async {
    try{
      await _firebaseAuth.currentUser.updateProfile(displayName: name);
    } catch (e){
      return Future.error(e);
    }
  }
  
  Future<void> setDisplayPicture(String url) async {
    try{
      await _firebaseAuth.currentUser.updateProfile(photoURL: url);
    } catch (e){
      return Future.error(e);
    }
  }
}

enum AuthState{
  logged_in,
  logged_out,
}