import 'package:shoe_box/models/user_model.dart';
import 'package:shoe_box/providers/product_provider.dart';
import 'package:shoe_box/services/user_service.dart';
import 'package:shoe_box/utils/app_utils.dart';
import 'package:shoe_box/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    if (_token == null) _settoken();
  }

  String? _token;
  String get token => _token ?? '';
  void _settoken() async {
    _token = await LocalStorage.gettoken();
    notifyListeners();
  }

  UserModel _user = UserModel();
  UserModel get user => _user;

  set setuserdetails(Map<String, dynamic> userdetails) {
    _user = UserModel.fromMap(userdetails);
    notifyListeners();
  }

  void updateUserDetailsFromModel(UserModel newmodel) {
    _user = newmodel;
    notifyListeners();
  }

  Future<void> getUserdetails(BuildContext context) async {
    try {
      final resp = await UserService.getUserDetails(context);
      if (resp.data != null) {
        setuserdetails = Map.from(resp.data);
        await LocalStorage.setuserdetails(resp.data);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToCart(BuildContext context, String id) async {
    try {
      showLoading(context);
      final resp = await UserService.addToCart(id);
      stopLoading(context);
      if (resp.data != null) {
        showSnackBar(context, 'Added to cart');
        await context.read<ProductProvider>().getProductsList(context);
        await getUserdetails(context);
      }
    } catch (e) {
      stopLoading(context);
      showSnackBar(context, e.toString());
    }
  }

  void modifyQuantity(
    BuildContext context,
    String productid,
    bool isAddQuantity,
  ) async {
    try {
      final resp = isAddQuantity
          ? await UserService.increaseQuantity(productid)
          : await UserService.decreaseQuantity(productid);

      if (resp.data != null) {
        final updatedcart = user.copywith(
          cart: [
            ...List.from(resp.data).map((e) => CartItems.fromMap(e)),
          ],
        );

        updateUserDetailsFromModel(updatedcart);
      }
    } catch (e) {
      stopLoading(context);
      showSnackBar(context, e.toString());
    }
  }
}
