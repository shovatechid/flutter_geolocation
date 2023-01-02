import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Position? getPosition;
var lat, long;
String? currentAddress, message, myCoordinates;

Future<bool> _handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    message = "Layanan lokasi dinonaktifkan. Harap aktifkan layanan";
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
       message= "Izin lokasi ditolak";
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    message= "Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin";
    return false;
  }
  return true;
}

Future<void> _getAddressFromLatLng(Position position, insetState) async {

  await placemarkFromCoordinates(getPosition!.latitude, getPosition!.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    insetState(() {
    currentAddress =
         '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        //'${place.subLocality}, ${place.country}';
    });
  }).catchError((e) {
    debugPrint(e);
  });
}

Future<void> getCoordinates(insetState) async {
  final hasPermission = await _handleLocationPermission();

  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
      insetState(() => getPosition = position);
      _getAddressFromLatLng(getPosition!, insetState);
      lat = getPosition?.latitude;
      long = getPosition?.longitude;
    myCoordinates = lat.toString() + "," + long.toString();
  }).catchError((e) {
   debugPrint(e);
  });

}
