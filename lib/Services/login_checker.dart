import 'package:appsensi_test/Models/User.dart';
import 'package:appsensi_test/Screens/home.dart';
import 'package:appsensi_test/Screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Checker extends StatefulWidget {
  static const routeName ='/checker';
  @override
  _CheckerState createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    if (user==null) {
      return LoginScreen();
    } else {
      return Home();
    }

  }
}