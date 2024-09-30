import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/formatters/formatter.dart';
import 'package:mobile/utils/helpers/get_storage.dart';
import 'package:mobile/utils/http/response_props.dart';

class THttpUpload {
  static const String _baseUrl = 'https://landlapi.ddnsking.com/api';
  static final deviceStorage = GetStorage();
  static bool _isRetry = false;

  static String? _getToken() {
    return deviceStorage.read('token'); // Read the token from storage
  }


  static Future<ResponseProps<T>> get<T>(String endpoint) async {
    try {
      final token = _getToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Authorization': 'Bearer $token'},
      );
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
      String endpoint, File frontImage, File backImage) async {
    try {
      ResponseProps<String> refresh = await get('Auth/refresh-token');
      String? newToken = refresh.result?.data;

      deviceStorage.write('token', newToken);

      var request = http.MultipartRequest(
          'PATCH', Uri.parse('https://landlapi.ddnsking.com/api/$endpoint'))
        ..headers.addAll({
          'Authorization': 'Bearer $newToken',
          'Content-Type': "multipart/form-data"
        });

      request.files.add(
          await http.MultipartFile.fromPath('imageFront', frontImage.path));
      request.files
          .add(await http.MultipartFile.fromPath('imageBack', backImage.path ));
      print(request.files[0].filename);
      print(request.files[1].filename);
      print(request.url);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return _handleResponse<T>(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ResponseProps<T>> patchData<T>(
      String endpoint, dynamic data) async {
    try {
      final token = _getToken();

      var request = http.MultipartRequest(
          'PATCH', Uri.parse('https://landlapi.ddnsking.com/api/$endpoint'))
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': "multipart/form-data"
        });

      data.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty && value.toString() != "N/A") {
          if (kDebugMode) {
            print("$key - ${value.toString()}");
          }
          if (key == "dob" || key == "doe" || key == "issue_date") {
            request.fields[key] = TFormatter.formatDateToDB(value);
          } else {
            request.fields[key] = value.toString();
          }
        }
      });
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(">>>>>>>>>>>>>>>>>> ${response.body}");
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
