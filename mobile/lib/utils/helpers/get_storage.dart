import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

final box = GetStorage();

LatLng getCurrentLatLngFromGetStorage() {
  return LatLng(
    box.read<double>('latitude')!,
    box.read<double>('longitude')!,
  );
}

String getCurrentAddressFromGetStorage() {
  return box.read<String>('current-address')!;
}

LatLng getTripLatLngFromGetStorage(String type) {
  var sourceLocation = box.read<Map<String, dynamic>>('source')!;
  var destinationLocation = box.read<Map<String, dynamic>>('destination')!;

  LatLng source =
      LatLng(sourceLocation['location'][0], sourceLocation['location'][1]);
  LatLng destination = LatLng(
      destinationLocation['location'][0], destinationLocation['location'][1]);

  return type == 'source' ? source : destination;
}

String getSourceAndDestinationPlaceText(String type) {
  var source = box.read<Map<String, dynamic>>('source')!;
  var destination = box.read<Map<String, dynamic>>('destination')!;

  return type == 'source' ? source['name'] : destination['name'];
}

void saveDirectionsAPIResponse(int index, String response) {
  box.write('package--$index', response);
}

Map getGeometryFromStorage(int index) {
  Map response = json.decode(box.read('package--$index')!);
  return response['geometry'];
}
