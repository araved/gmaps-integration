import 'package:appsensi_test/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Get Current User
  CurrentUser _user(User user){
    return user !=null ? CurrentUser(user.uid) : null;
  }

  Stream<CurrentUser> get currentuser {
    return _auth.authStateChanges().map(_user);
  }

  //Login with email and password
  Future signInWithEmailAndPassword(String email, String pwd) async
  {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Register User
  Future registerUser(String email, String pwd, String name) async
  {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
      if (user !=null) {
        _auth.currentUser.updateProfile(displayName: name);
      }
    } catch (e) {
    }
  }

  //Log out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}