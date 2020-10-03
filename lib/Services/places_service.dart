import 'package:appsensi_test/Models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {

  final key = 'AIzaSyCNVgIjMtxl6QDPNaa2mEb6mgsQMoNvTBQ';

  Future<List<Place>> getRestaurant(double lat, double lng) async
  {
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=restaurant&rankby=distance&key=$key');
    var result = convert.jsonDecode(response.body);
    var decode = result['results'] as List;
    decode.map((places) => Place.fromJson(places)).toList();
  }

   Future<List<Place>> getAtm(double lat, double lng) async
  {
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=atm&rankby=distance&key=$key');
    var result = convert.jsonDecode(response.body);
    var decode = result['results'] as List;
    decode.map((places) => Place.fromJson(places)).toList();
  }
  
}