import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static const nameRoute = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
    RegExp _validName = RegExp(r'(\s|^)([a-z0-9]+)');

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}