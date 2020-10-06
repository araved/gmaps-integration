import 'package:appsensi_test/Models/User.dart';
import 'package:appsensi_test/Widget/error_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  //Get Current User
  CurrentUser _user(User user){
    return user !=null ? CurrentUser(user.uid) : null;
  }

  Future getCurrentUser() async{
    return _auth.currentUser;
  }

  Stream<CurrentUser> get currentuser {
    return _auth.authStateChanges().map(_user);
  }

  //Login with email and password
  Future signInWithEmailAndPassword(String email, String pwd, BuildContext context) async
  {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      return user;
    } catch (e) {
      print(e.toString());
      return showDialog(context: context, 
      barrierDismissible: true,
      child: Error('Invalid email or password')
      );
    }
  }
  //Register User
  Future registerUser(String email, String pwd, String name, BuildContext context) async
  {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
      if (user !=null) {
        _auth.currentUser.updateProfile(displayName: name);
      }
    } catch (e) {
       return showDialog(context: context, 
      barrierDismissible: true,
      child: Error('User already existed'));
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