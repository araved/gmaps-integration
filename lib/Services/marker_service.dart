
import 'package:appsensi_test/Models/atm.dart';
import 'package:appsensi_test/Models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  

  List<Marker> getMarkers(List<Place> places){
    var markers = List<Marker>();

    places.forEach((place) { 
      Marker marker = Marker(
        markerId:MarkerId(place.name),
        draggable: false,
        position: LatLng(place.geometry.location.lat, place.geometry.location.lng)
        );
         for (var i = 0; i < 10; i++) {
           markers.add(marker);
         }
    });
   return markers;
  }

  List<Marker> getAtm(List<Atm> atm){
    var markers = List<Marker>();

    atm.forEach((atm) { 
      Marker marker = Marker(
        markerId:MarkerId(atm.name),
        draggable: false,
        position: LatLng(atm.geometry.location.lat, atm.geometry.location.lng)
        );
         for (var i = 0; i < 10; i++) {
           markers.add(marker);
         }
    });
   return markers;
  }
}