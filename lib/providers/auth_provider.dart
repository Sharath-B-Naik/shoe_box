import 'package:shoe_box/navigation_screen.dart';
import 'package:shoe_box/providers/user_provider.dart';
import 'package:shoe_box/services/auth_service.dart';
import 'package:shoe_box/utils/app_utils.dart';
import 'package:shoe_box/utils/local_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum Auth { signin, signup }

class AuthProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Auth _auth = Auth.signup;
  Auth get auth => _auth;
  set auth(Auth auth) {
    _auth = auth;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUpUser(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    bool isFilled = name.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
    if (!isFilled) return showSnackBar(context, 'All fields are required');

    try {
      showLoading(context);
      final resp = await AuthService.signUpUser(
        name: name,
        email: email,
        password: password,
      );
      stopLoading(context);

      if (resp.data != null) {
        showSnackBar(context, 'Registration successful');
        auth = Auth.signin;
        passwordController.clear();
      } else {
        showSnackBar(context, resp.error!);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    bool isFilled = email.isNotEmpty && password.isNotEmpty;
    if (!isFilled) return showSnackBar(context, 'All fields are required');

    try {
      showLoading(context);
      final resp = await AuthService.signInUser(
        email: email,
        password: password,
      );
      stopLoading(context);

      if (resp.data != null) {
        showSnackBar(context, 'Login successful');
        await LocalStorage.settoken(resp.data!['token']);
        await LocalStorage.setuserdetails(Map.from(resp.data));
        context.read<UserProvider>().setuserdetails = Map.from(resp.data);
        Navigator.pushNamedAndRemoveUntil(
          context,
          NavigationPage.routename,
          (route) => false,
        );
      } else {
        showSnackBar(context, '${resp.error}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
