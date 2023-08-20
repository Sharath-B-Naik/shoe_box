import 'dart:convert';
import 'package:shoe_box/utils/local_storage.dart';
import 'package:http/http.dart' as http;

class ApiUtils {
  static Future<ApiResponse> get({required String url}) async {
    final token = await LocalStorage.gettoken();

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );

    return _response(response: response);
  }

  static Future<ApiResponse> post({required String url, Object? body}) async {
    final token = await LocalStorage.gettoken();
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
    );

    return _response(response: response);
  }

  static ApiResponse _response({required http.Response response}) {
    final responseData = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return ApiResponse(data: responseData);

      case 400:
        return ApiResponse(error: responseData['message']);

      case 401:
        return ApiResponse(error: responseData['message']);

      case 500:
        return ApiResponse(error: responseData['message']);

      default:
        return ApiResponse(error: 'Something went wrong');
    }
  }
}

class ApiResponse {
  final dynamic data;
  final String? error;

  ApiResponse({this.data, this.error});
}
