import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/requests/goong/direction.dart';
import 'package:mobile/utils/requests/goong/reserse_geocoding.dart';

LatLng getSouthwest(LatLng pos1, LatLng pos2) {
  return LatLng(
    pos1.latitude < pos2.latitude ? pos1.latitude : pos2.latitude,
    pos1.longitude < pos2.longitude ? pos1.longitude : pos2.longitude,
  );
}

LatLng getNortheast(LatLng pos1, LatLng pos2) {
  return LatLng(
    pos1.latitude > pos2.latitude ? pos1.latitude : pos2.latitude,
    pos1.longitude > pos2.longitude ? pos1.longitude : pos2.longitude,
  );
}
Future<Map> getParsedReverseGeocoding(LatLng latLng) async {
  var response = await getReverseGeocodingGivenLatLngUsingGoong(latLng);
  Map feature = response['results'][0];
  Map revGeocode = {'place': feature['formatted_address'], 'location': latLng};
  return revGeocode;
}

Future<Map<String, dynamic>> getDirectionsAPIResponse(
    LatLng sourceLatLng, LatLng destinationLatLng) async {
  final response =
      await getCyclingRouteUsingGoong(sourceLatLng, destinationLatLng);
  List geometry = response['routes'][0]['legs'][0]['steps'];
  String duration = response['routes'][0]['legs'][0]['duration']['text'];
  String distance = response['routes'][0]['legs'][0]['distance']['text'];
  String srcName = response['routes'][0]['legs'][0]['start_address'];
  String desName = response['routes'][0]['legs'][0]['end_address'];
  String route = response['routes'][0]['overview_polyline']['points'];

  Map<String,dynamic> modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
    'sourceName': srcName,
    'destinationName': desName,
    'route': route
  };
  return modifiedResponse;
}

Future<Map> getDirectionsManyAPIResponse(
    LatLng sourceLatLng, List<LatLng> destinationLatLngs) async {
  final response = await getCyclingRouteManyDestinationUsingGoong(
      sourceLatLng, destinationLatLngs);
  List geometry = response['routes'][0]['legs'][0]['steps'];
  String duration = response['routes'][0]['legs'][0]['duration']['text'];
  String distance = response['routes'][0]['legs'][0]['distance']['text'];
  String srcName = response['routes'][0]['legs'][0]['start_address'];
  String desName = response['routes'][0]['legs'][0]['end_address'];
  String route = response['routes'][0]['overview_polyline']['points'];

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
    'sourceName': srcName,
    'destinationName': desName,
    'route': route
  };
  return modifiedResponse;
}
