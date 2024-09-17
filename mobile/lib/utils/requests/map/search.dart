import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/http/http_client.dart';

final box = GetStorage();
String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
String searchType = 'place%2Cpostcode%2Caddress';
String searchResultsLimit = '5';
String proximity =
    '${box.read<double>('latitude')}%2C${box.read<double>('latitude')}';
String country = 'vn';

Future getSearchResultsFromQueryUsingMapbox(String query) async {
  String url =
      '$baseUrl/$query.json?country=$country&limit=$searchResultsLimit&proximity=$proximity&types=$searchType&access_token=$accessToken';
  await THttpClient.getDynamic(url);
}
