import 'package:appsensi_test/Models/place.dart';
import 'package:appsensi_test/Services/marker_service.dart';
import 'package:appsensi_test/Widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RestaurantScreen extends StatefulWidget {
  static const nameRoute = '/restaurant';
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
    final markerService = MarkerService();

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
            (currentLocation != null )
                ? Consumer<List<Place>>(
                    builder: (_, places, __) {
                      var markers = (places != null) ? markerService.getMarkers(places) : List<Marker>();
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(currentLocation.latitude,
                                      currentLocation.longitude),
                                  zoom: 18),
                              zoomGesturesEnabled: true,
                              myLocationEnabled: true,
                              onMapCreated: _onMapCreated,
                              markers: Set<Marker>.of(markers),
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
                            child: places == null ? CircularProgressIndicator() : ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(places[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text(places[index].vicinity),
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
