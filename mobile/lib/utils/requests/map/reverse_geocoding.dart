import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/http/http_client.dart';

String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken = "pk.eyJ1IjoiaGlldXNlcnZpY2VzIiwiYSI6ImNsdmlidHppNzA5cjAya3M0N3c1NTRtY3IifQ.ne-z1KUE3g8g2HeKyVrtuw&sku=100m1r6hdry81b13d3eb8d744e0aa1821d054400a6a";

Future<Map<String, dynamic>> getReverseGeocodingGivenLatLngUsingMapbox(
    LatLng latLng) async {
  String query = '${latLng.longitude},${latLng.latitude}';
  String url = '$baseUrl/$query.json?access_token=$accessToken';
  return await THttpClient.getDynamic(url);
}
