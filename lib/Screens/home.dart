import 'package:appsensi_test/Models/User.dart';
import 'package:appsensi_test/Models/place.dart';
import 'package:appsensi_test/Screens/atm.dart';
import 'package:appsensi_test/Screens/restaurant.dart';
import 'package:appsensi_test/Services/auth.dart';
import 'package:appsensi_test/Services/login_checker.dart';
import 'package:appsensi_test/Widget/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const nameRoute = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  int _currentIndex =0;
    List<Map<String, Object>> _pages;
@override
  void initState() {
    _pages = [
      {
        'page': RestaurantScreen(),
        
      },
      {
        'page': AtmScreen(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  GoogleMapController mapController;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
      final currentLocation = Provider.of<Position>(context);
      final placesProvide = Provider.of<Future<List<Place>>>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant), label: 'Restaurant'),
        BottomNavigationBarItem(icon: Icon(Icons.atm), label: 'ATM')
      ]),
      body:  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: [
            SizedBox(height: 70),
            Header(),
            (currentLocation !=null) ? Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(3.127030, 101.617510), zoom: 15),
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
              ),
            ):  Center(
        child: CircularProgressIndicator(),)
          ],
        ),
      ) 
      
    );
  }
}
