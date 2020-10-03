import 'package:geolocator/geolocator.dart';

class GeoLocator {



  Future<Position> geoLocation() async {
    return await GeolocatorPlatform.instance.getCurrentPosition(
      
    );
  }
}
