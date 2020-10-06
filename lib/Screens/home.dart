import 'package:appsensi_test/Models/User.dart';
import 'package:appsensi_test/Models/place.dart';
import 'package:appsensi_test/Screens/atm_page.dart';
import 'package:appsensi_test/Screens/restaurant_page.dart';
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
  

  GoogleMapController mapController;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height >= 800 ? 70
                   :MediaQuery.of(context).size.height /30),
            Header(),
            currentLocation != null
                ? Container(
                    height: MediaQuery.of(context).size.height / 1.35,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation.latitude,
                              currentLocation.longitude),
                          zoom: 15),
                      myLocationEnabled: true,
                      onMapCreated: _onMapCreated,
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Expanded(
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.restaurant,
          color: Colors.black,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          "Restaurant",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
  onPressed: () => Navigator.of(context).pushNamed(RestaurantScreen.nameRoute),
),
                FlatButton(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.atm,
          color: Colors.black,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          "Atm",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
  onPressed: () => Navigator.of(context).pushNamed(AtmScreen.nameRoute),
),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
