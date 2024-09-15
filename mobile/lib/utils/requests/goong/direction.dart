import 'dart:ffi';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/http/http_client.dart';

String baseUrl = 'https://rsapi.goong.io/Direction';
String apiKey = dotenv.env['API_KEY_GOONG']!;
String navType = 'driving';

Future<Map<String, dynamic>> getCyclingRouteUsingGoong(
    LatLng source, LatLng destination) async {
  String url =
      '$baseUrl?origin=${source.longitude},${source.latitude}&destination=${destination.longitude},${destination.latitude}&vehicle=car&api_key=$apiKey';

  return await THttpClient.getDynamic(url);
}

Future<Map<String, dynamic>> getCyclingRouteManyDestinationUsingGoong(
    LatLng source, List<LatLng> destinations) async {
  List<String> listDestination = [];
  for (LatLng destination in destinations) {
    String temp = '${destination.longitude},${destination.latitude}';
    listDestination.add(temp);
  }
  String query = listDestination.join(';');
  String url =
      '$baseUrl?origin=${source.longitude},${source.latitude}&destination=$query&vehicle=car&api_key=$apiKey';

  return await THttpClient.getDynamic(url);
}
