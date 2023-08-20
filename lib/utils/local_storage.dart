import 'dart:convert';

import 'package:shoe_box/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const _storage = FlutterSecureStorage();
  static void clearAll() => _storage.deleteAll();

  static Future<void> settoken(String? token) async {
    _storage.write(key: 'token', value: token);
  }

  static Future<String> gettoken() async {
    return (await _storage.read(key: 'token')) ?? '';
  }

  static Future<void> setuserdetails(Map<String, dynamic> userdetails) async {
    _storage.write(key: 'userdetails', value: jsonEncode(userdetails));
  }

  static Future<UserModel> getuserdetails() async {
    final data = await _storage.read(key: 'userdetails');
    return UserModel.fromMap(jsonDecode(data!));
  }
}
