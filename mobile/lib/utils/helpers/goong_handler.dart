import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/requests/goong/direction.dart';
import 'package:mobile/utils/requests/goong/reserse_geocoding.dart';

Future<Map> getParsedReverseGeocoding(LatLng latLng) async {
  var response = await getReverseGeocodingGivenLatLngUsingGoong(latLng);
  Map feature = response['results'][0];
  Map revGeocode = {
    'place': feature['formatted_address'],
    'location': latLng
  };
  return revGeocode;
}


Future<Map> getDirectionsAPIResponse(
    LatLng sourceLatLng, LatLng destinationLatLng) async {
  final response =
  await getCyclingRouteUsingGoong(sourceLatLng, destinationLatLng);
  Map geometry = response['routes'][0]['legs'][0]['steps'];
  num duration = response['routes'][0]['legs']['duration']['value'];
  num distance = response['routes'][0]['legs']['distance']['value'];
  String srcName = response['routes'][0]['legs']['start_address'];
  String desName = response['routes'][0]['legs']['end_address'];


  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
    'sourceName': srcName,
    'destinationName': desName
  };
  return modifiedResponse;
}

Future<Map> getDirectionsManyAPIResponse(
    LatLng sourceLatLng, List<LatLng> destinationLatLngs) async {
  final response =
  await getCyclingRouteManyDestinationUsingGoong(sourceLatLng, destinationLatLngs);
  Map geometry = response['routes'][0]['legs'][0]['steps'];
  num duration = response['routes'][0]['legs']['duration']['value'];
  num distance = response['routes'][0]['legs']['distance']['value'];
  String srcName = response['routes'][0]['legs']['start_address'];
  String desName = response['routes'][0]['legs']['end_address'];


  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
    'sourceName': srcName,
    'destinationName': desName
  };
  return modifiedResponse;
}