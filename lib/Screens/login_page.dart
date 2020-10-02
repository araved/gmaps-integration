import 'package:appsensi_test/Services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String nameRoute = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Auth _auth = Auth();
  RegExp _validName = RegExp(r'(\s|^)([a-z0-9]+)');
  RegExp _validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Form(
        key: _formKey,
              child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty || !_validEmail.hasMatch(value)) {
                  return 'Invalid Email';
                } 
              },
            ),
            RaisedButton(onPressed: ()=>{})
            
          ],
        ),
      )
    );
  }
}