import 'package:appsensi_test/Models/User.dart';
import 'package:appsensi_test/Models/place.dart';
import 'package:appsensi_test/Screens/login_page.dart';
import 'package:appsensi_test/Screens/register_page.dart';
import 'package:appsensi_test/Services/locator.dart';
import 'package:appsensi_test/Services/login_checker.dart';
import 'package:appsensi_test/Services/places_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'Screens/home.dart';
import 'Services/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PlacesService _placesService = PlacesService();
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
                StreamProvider<CurrentUser>.value(value: Auth().currentuser),
                Provider.value(value: Auth()),
                FutureProvider.value(value: GeoLocator().geoLocation()),
                ProxyProvider<Position,Future<List<Place>>>(
                  update: (context, position, places) {
                    return (position !=null) ? _placesService.getRestaurant(position.latitude, position.longitude) : null;
                  },
                ),
                // ProxyProvider<Position,Future<List<Place>>>(
                //   update: (context, position, places) {
                //     return (position !=null) ? _placesService.getAtm(position.latitude, position.longitude) : null;
                //   },
                // )
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                  
                  ),
                  home: Checker(),
                  routes: {
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    Checker.routeName: (ctx) => Checker(),
                    Register.nameRoute: (ctx) => Register(),
                    Home.nameRoute: (ctx) => Home(),
                    
                  }),
            );
          }
        });
  }
}
