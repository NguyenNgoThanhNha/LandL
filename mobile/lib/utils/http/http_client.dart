import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/http/response_props.dart';

class THttpClient {
  static const String _baseUrl = 'https://landlapi.ddnsking.com/api';
  static final deviceStorage = GetStorage();
  static bool _isRetry = false;

  static String? _getToken() {
    return deviceStorage.read('token');
  }

  static Future<ResponseProps<T>> get<T>(String endpoint) async {
    try {
      final token = _getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print("Old TK $token");
      print('$_baseUrl/$endpoint');
      print("${response.statusCode}");
      print("${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return _handleResponse<T>(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> getDynamic<T>(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );
    return _handleResponseDynamic(response);
  }

  static Future<ResponseProps<T>> post<T>(String endpoint, dynamic data) async {
    try {
      print('$_baseUrl/$endpoint');
      print(json.encode(data));
      final token = _getToken();
      final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(data));
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return _handleResponse<T>(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      print(e);
      return _handleError(e);
    }
  }

  static Future<ResponseProps<T>> put<T>(String endpoint, dynamic data) async {
    try {
      final token = _getToken();
      final response = await http.put(Uri.parse('$_baseUrl/$endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(data));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return _handleResponse<T>(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ResponseProps<T>> patch<T>(
      String endpoint, dynamic data) async {
    try {
      print(">>>>>>>>>>>>>>>>>>>>>> data $data");
      final token = _getToken();
      final response = await http.patch(Uri.parse('$_baseUrl/$endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(data));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return _handleResponse<T>(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ResponseProps<T>> delete<T>(String endpoint) async {
    try {
      final token = _getToken();
      final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return _handleResponse<T>(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  static ResponseProps<T> _handleResponse<T>(http.Response response) {
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final result = jsonResponse['result'] != null
          ? Result<T>(
              message: jsonResponse['result']['message'],
              data: jsonResponse['result']['data'])
          : null;

      return ResponseProps<T>(success: true, result: result);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Map<String, dynamic> _handleResponseDynamic(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future<ResponseProps<T>> _handleError<T>(dynamic error) async {
    if (error is http.Response) {
      if (error.statusCode == 401 && !_isRetry) {
        _isRetry = true;
        ResponseProps<String> refresh = await get('Auth/refresh-token');
        print('requesting new token...');
        if (refresh.success) {
          _isRetry = false;
          String? newToken = refresh.result?.data;

          deviceStorage.write('token', newToken);

          print('Updated request with new token: ${error.request!}');

          final originalRequest = http.Request(
              error.request!.method, error.request!.url)
            ..headers.addAll(error.request!.headers) // Copy existing headers
            ..headers['Authorization'] =
                'Bearer $newToken'; // Add new Authorization header

          if (error.request is http.Request && error.request!.method != 'GET') {
            originalRequest.body = (error.request as http.Request)
                .body; // Copy the request body if applicable
          }

          final retriedResponse = await http.Client().send(originalRequest);
          print('Retrying original request...');
          final retriedHttpResponse =
              await http.Response.fromStream(retriedResponse);
          print('Retrying done, status: ${retriedHttpResponse.statusCode}');
          if (retriedHttpResponse.statusCode >= 200 &&
              retriedHttpResponse.statusCode < 300) {
            return _handleResponse<T>(retriedHttpResponse);
          } else {
            return _handleError(retriedHttpResponse);
          }
        } else {
          _isRetry = false;
          return ResponseProps<T>(
            success: false,
            result: Result(
              message: 'Please login to access this resource',
            ),
          );
        }
      }
      final jsonResponse = json.decode(error.body);
      final result = jsonResponse['result'] != null
          ? Result<T>(
              message: jsonResponse['result']['message'],
              data: jsonResponse['result']['data'])
          : null;
      return ResponseProps<T>(success: false, result: result);
    } else {
      return ResponseProps<T>(
        success: false,
        result: Result(
          message: 'An unexpected error occurred',
        ),
      );
    }
  }
}
