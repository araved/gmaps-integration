import 'package:appsensi_test/Screens/register_page.dart';
import 'package:appsensi_test/Services/auth.dart';
import 'package:appsensi_test/Services/login_checker.dart';
import 'package:appsensi_test/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Auth _auth = Auth();
  RegExp _validEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _hidden = true;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

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
    setState(() {
      _isLoading = true;
    });
    await _auth.signInWithEmailAndPassword(
        _authData['email'], _authData['password'], context);
        Navigator.of(context).pushNamed(Checker.routeName);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Form(
        key: _formKey,
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('Assets/Images/Firebase_logo.png'),
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: 350.0, maxHeight: 70.0),
                      child: TextFormField(
                        //Email
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 15.0),
                              child: Text(
                                '@',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: 350.0, maxHeight: 100.0),
                      child: TextFormField(
                        //Password
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 10.0),
                              child: Icon(Icons.lock)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                              icon: _hidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: _setVisibility),
                        ),
                        obscureText: _hidden,
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (newValue) => _authData['password'] = newValue,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      Button('Login', _submit),
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account?"),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FlatButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(Register.nameRoute),
                                  child: Text("Register",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
