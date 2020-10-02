import 'package:appsensi_test/Models/User.dart';
import 'package:appsensi_test/Screens/login_page.dart';
import 'package:appsensi_test/Screens/register_page.dart';
import 'package:appsensi_test/Services/login_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(), //Initialize firebase connection
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.connectionState == ConnectionState.done) {

            return MultiProvider(
              providers: [
                StreamProvider<CurrentUser>.value(value: Auth().currentuser)
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                  
                  ),
                  home: Checker(),
                  routes: {
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    Checker.routeName: (ctx) => Checker(),
                    Register.nameRoute: (ctx) => Register()
                    
                  }),
            );
          }
        });
  }
}
