import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/http/http_client.dart';

String baseUrl = 'https://rsapi.goong.io/Geocode';
String apiKey = dotenv.env['API_KEY_GOONG']!;

Future<Map<String, dynamic>> getReverseGeocodingGivenLatLngUsingGoong(
    LatLng latLng) async {
  String query = 'latlng=${latLng.latitude},${latLng.longitude}';
  String url = '$baseUrl?$query&api_key=$apiKey';
  return await THttpClient.getDynamic(url);
}
