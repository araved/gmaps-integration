import 'package:appsensi_test/Models/atm.dart';
import 'package:appsensi_test/Models/place.dart';
import 'package:appsensi_test/Services/marker_service.dart';
import 'package:appsensi_test/Widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class AtmScreen extends StatefulWidget {
  static const nameRoute = '/atm';
  @override
  _AtmScreenState createState() => _AtmScreenState();
}

class _AtmScreenState extends State<AtmScreen> {
  GoogleMapController mapController;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    final atmProvider = Provider.of<Future<List<Atm>>>(context);
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => atmProvider,
      child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: [
            SizedBox(height: 70),
            Header(),
            (currentLocation != null )
                ? Consumer<List<Atm>>(
                    builder: (_, places, __) {
                      var markers = (places != null) ? markerService.getAtm(places) : List<Marker>();
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(currentLocation.latitude,
                                      currentLocation.longitude),
                                  zoom: 17.0),
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
                                      'ATM',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                    icon: Icon(Icons.atm,
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
                            child: places == null ? CircularProgressIndicator() :ListView.builder(
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