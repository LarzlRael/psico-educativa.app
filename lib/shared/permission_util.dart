

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void checkGPSAccess(PermissionStatus status) {
  switch (status) {
    case PermissionStatus.granted:
      /* Navigator.pushReplacementNamed(context, 'mapa'); */
      break;

    case PermissionStatus.denied:
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
    case PermissionStatus.permanentlyDenied:
      openAppSettings();
      break;
    case PermissionStatus.provisional:
      // TODO: Handle this case.
  }
}

Future<LatLng> getLocation() async {
  LocationPermission permission;
  permission = await Geolocator.requestPermission();

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  double lat = position.latitude;
  double long = position.longitude;

  return LatLng(lat, long);
}

/* int randomInt(List<dynamic> list) {
  if (list.length == 1) {
    return 0;
  }
  final random = Random();
  final i = random.nextInt(list.length);
  return i;
}
 */