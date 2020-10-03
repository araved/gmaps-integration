import 'package:appsensi_test/Models/User.dart';
import 'package:appsensi_test/Services/auth.dart';
import 'package:appsensi_test/Services/login_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final Auth _auth = Auth();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static const nameRoute = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: [
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.account_circle_rounded, color: Colors.white,size: 40,),
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        _firebaseAuth.currentUser.displayName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(_firebaseAuth.currentUser.email)
                    ],
                  ),
                  SizedBox(width: 90),
                  RaisedButton(
                    onPressed: () async {
                      _auth.signOut();
                      Navigator.of(context)
                          .pushReplacementNamed(Checker.routeName);
                    },
                    color: Colors.red,
                    child: Text('Logout'),
                    
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
