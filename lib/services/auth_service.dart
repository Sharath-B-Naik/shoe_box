import 'package:shoe_box/config/secrets/secrets.dart';
import 'package:shoe_box/utils/api_utils.dart';

class AuthService {
  static Future<ApiResponse> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    final resp = await ApiUtils.post(
      url: '$uri/api/signup',
      body: {
        "name": name,
        "email": email,
        "password": password,
        "type": "user",
      },
    );

    return resp;
  }

  // sign in user
  static Future<ApiResponse> signInUser({
    required String email,
    required String password,
  }) async {
    final resp = await ApiUtils.post(
      url: '$uri/api/signin',
      body: {
        "email": email,
        "password": password,
      },
    );

    return resp;
  }
}
