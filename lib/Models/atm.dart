import 'geometry.dart';

class Atm{
  final String name;
  final String vicinity;
  final Geometry geometry;

  Atm({this.geometry, this.name,  this.vicinity});

  Atm.fromJson(Map<dynamic, dynamic> parsedJson)
    :name = parsedJson['name'],
    vicinity = parsedJson['vicinity'],
    geometry = Geometry.fromJson(parsedJson['geometry']);

}