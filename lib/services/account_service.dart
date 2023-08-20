import 'package:shoe_box/config/secrets/secrets.dart';
import 'package:shoe_box/utils/api_utils.dart';

class AccountService {
  static Future<ApiResponse> makeAdmin() async {
    final resp = await ApiUtils.get(url: '$uri/api/make-admin');
    return resp;
  }
}
