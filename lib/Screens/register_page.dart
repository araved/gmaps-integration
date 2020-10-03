import 'package:appsensi_test/Screens/home.dart';
import 'package:appsensi_test/Screens/login_page.dart';
import 'package:appsensi_test/Services/auth.dart';
import 'package:appsensi_test/Widget/button.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static const nameRoute = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Auth _auth = Auth();
  RegExp _validName = RegExp(r'\s|^[A-Z]');
  RegExp _validEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _hidden = true;
  final _passwordController = TextEditingController();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
  };

  void _setVisibility() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    _formKey.currentState.save();
    await _auth.registerUser(
        _authData['email'], _authData['password'], _authData['name']);
    Navigator.of(context).pushReplacementNamed(Home.nameRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop()),
                      Text(
                        'Create new account',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Image(
                    image: AssetImage('Assets/Images/Firebase_logo.png'),
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 30),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: 400.0, maxHeight: 70.0),
                    child: TextFormField(
                      //Full Name
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the field';
                        }
                        if (!_validName.hasMatch(value)) {
                          return 'Please use capital letter for the first character of each word';
                        }
                      },
                      onSaved: (newValue) => _authData['name'] = newValue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: 400.0, maxHeight: 70.0),
                    child: TextFormField(
                      //Email
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !_validEmail.hasMatch(value)) {
                          return 'Invalid Email';
                        }
                      },
                      onSaved: (newValue) => _authData['email'] = newValue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(children: [
                            TextFormField(
                              //Password
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              obscureText: _hidden,
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                              },
                              onSaved: (newValue) =>
                                  _authData['password'] = newValue,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              //Password
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              obscureText: _hidden,
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Password does not match!';
                                }
                              },
                            ),
                          ]),
                        ),
                        Expanded(
                            flex: 0,
                            child: IconButton(
                                icon: _hidden
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: _setVisibility))
                      ]),
                  SizedBox(height: 30),
                  Button('Register', _submit)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
