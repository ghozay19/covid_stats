


import 'dart:async';
import 'package:covid_stats/core/model/user_location.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LoctService {
  StreamSubscription<Position> _positionStream;
  Geolocator _geolocator;
  UserLocation _currentLocation;
  String lokasi;


  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>.broadcast();

  LoctService() {
    _geolocator = Geolocator();

    var locationOptions = LocationOptions(accuracy: LocationAccuracy.best);

    try {
      _positionStream =
          _geolocator.getPositionStream(locationOptions).listen((position) {
            if (position != null) {
              getCurrentPosition(_currentLocation);

              _locationController.add(UserLocation(
                  latitude: position.latitude, longitude: position.longitude));
            }
          });
    } on PlatformException catch (_) {
      print("Permission denied");
    }
  }

  Future<UserLocation> getCurrentPosition(UserLocation position) async {
    try {
      var userLocation = await _geolocator.getCurrentPosition();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude, longitude: userLocation.longitude);

      var resultList = await _geolocator.placemarkFromCoordinates(
          _currentLocation.latitude, _currentLocation.longitude,
          localeIdentifier: "id-ID");

      if (resultList.length > 0) {
        Placemark firstResult = resultList[0];

        lokasi = firstResult.thoroughfare +
            " " +
            firstResult.subThoroughfare +
            ", " +
            firstResult.locality;

      }

    } catch (e) {
      print('could not get the location $e');
    }
    return _currentLocation;
  }

  Stream<UserLocation> get locationStream => _locationController.stream;


}
