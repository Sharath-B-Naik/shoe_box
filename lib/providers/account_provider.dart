import 'package:shoe_box/providers/user_provider.dart';
import 'package:shoe_box/services/account_service.dart';
import 'package:shoe_box/utils/app_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AccountProvider extends ChangeNotifier {
  final BuildContext context;
  AccountProvider(this.context) {
    isAdmin = context.read<UserProvider>().user.type == "admin";
  }
  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  set isAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

  Future<void> makeAdmin(BuildContext context) async {
    try {
      isAdmin = !isAdmin;
      final resp = await AccountService.makeAdmin();

      if (resp.data != null) {
        await context.read<UserProvider>().getUserdetails(context);
      } else {
        isAdmin = false;
        showSnackBar(context, resp.error!);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
