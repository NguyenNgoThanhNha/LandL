import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/http/http_client.dart';

String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String accessToken = "pk.eyJ1IjoiaGlldXNlcnZpY2VzIiwiYSI6ImNsdmlidHppNzA5cjAya3M0N3c1NTRtY3IifQ.ne-z1KUE3g8g2HeKyVrtuw&sku=100m1r6hdry81b13d3eb8d744e0aa1821d054400a6a";
String navType = 'driving';

Future<Map<String, dynamic>> getCyclingRouteUsingMapbox(LatLng source, LatLng destination) async {
  String url =
      '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';

  return await THttpClient.getDynamic(url);
}
