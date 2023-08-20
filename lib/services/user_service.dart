import 'package:shoe_box/config/secrets/secrets.dart';
import 'package:shoe_box/utils/api_utils.dart';
import 'package:flutter/material.dart';

class UserService {
  // get user data
  static Future<ApiResponse> getUserDetails(BuildContext context) async {
    final resp = await ApiUtils.get(url: '$uri/api/user/get-details');
    return resp;
  }

  static Future<ApiResponse> addToCart(String productid) async {
    final response = await ApiUtils.post(
      url: '$uri/api/cart/add',
      body: {"id": productid},
    );

    return response;
  }

  static Future<ApiResponse> increaseQuantity(String productid) async {
    final response = await ApiUtils.post(
      url: '$uri/api/cart/increase-quantity',
      body: {"id": productid},
    );

    return response;
  }

  static Future<ApiResponse> decreaseQuantity(String productid) async {
    final response = await ApiUtils.post(
      url: '$uri/api/cart/decrease-quantity',
      body: {"id": productid},
    );

    return response;
  }
}
