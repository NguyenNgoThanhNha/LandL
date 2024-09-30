import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/http/response_props.dart';

class THttpScan {
  static Future<Map<String, dynamic>?> scanIdCard(File imageFile) async {
    String apiIdCard = 'iUE6MvbIhBB5hbTve3jLN6RIyjanUb6Z';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.fpt.ai/vision/idr/vnm'),
    );
    request.headers['api-key'] = apiIdCard;
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return json.decode(utf8.decode(response.bodyBytes));
  }

  static Future<ResponseProps?> scanDriverCard(File imageFile) async {
    String apiIdCard = 'iUE6MvbIhBB5hbTve3jLN6RIyjanUb6Z';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.fpt.ai/vision/idr/vnm'),
    );
    request.headers['api-key'] = apiIdCard;
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    // return json.decode(response.body);
  }

// static Future<ResponseProps> uploadDataServer(dynamic data) async{
//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse('https://api.fpt.ai/vision/idr/vnm'),
//   );
//   request.headers['api-key'] = apiIdCard;
// }
}
