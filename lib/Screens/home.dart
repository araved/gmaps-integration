import 'package:appsensi_test/Services/auth.dart';
import 'package:appsensi_test/Services/login_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        shadowColor: Colors.white,
        elevation: 0,
        
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Page'),
            RaisedButton(onPressed: () async {
              _auth.signOut();
                            Navigator.of(context).pushReplacementNamed(Checker.routeName);

            })
          ],
        )),
      ),
    );
  }
}
