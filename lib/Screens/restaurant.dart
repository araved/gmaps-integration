import 'package:appsensi_test/Models/place.dart';
import 'package:appsensi_test/Widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
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
            SizedBox(height: 70),
            Header(),
            (currentLocation != null)
                ? Consumer<List<Place>>(
                    builder: (_, places, __) {
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(currentLocation.latitude,
                                      currentLocation.longitude),
                                  zoom: 16.0),
                              zoomGesturesEnabled: true,
                              myLocationEnabled: true,
                              onMapCreated: _onMapCreated,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxHeight: 100),
                            child: SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  TextButton.icon(
                                    label: Text(
                                      'Restaurant',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                    icon: Icon(Icons.restaurant,
                                        color: Colors.black),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(Home.nameRoute),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(places[index].name),
                                  );
                                },
                              ),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
      ),
    );
  }
}
