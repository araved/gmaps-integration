import 'package:appsensi_test/Services/auth.dart';
import 'package:appsensi_test/Services/login_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final Auth _auth = Auth();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.
                // ),
                width: double.infinity,
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        children: [
                          Text(
                            _firebaseAuth.currentUser.displayName !=null ? _firebaseAuth.currentUser.displayName : 'Loading Username',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(_firebaseAuth.currentUser.email !=null? _firebaseAuth.currentUser.email : 'Loading E-Mail')
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width /6),
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
            );
  }
}