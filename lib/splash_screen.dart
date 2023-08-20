import 'package:shoe_box/navigation_screen.dart';
import 'package:shoe_box/providers/user_provider.dart';
import 'package:shoe_box/screens/Auth/auth_page.dart';
import 'package:shoe_box/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigateToNextPage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    final token = await LocalStorage.gettoken();

    if (token.isNotEmpty) {
      await context.read<UserProvider>().getUserdetails(context);
    }

    Navigator.pushAndRemoveUntil(
      context,
      token.isEmpty
          ? MaterialPageRoute(builder: (_) => const AuthPage())
          : MaterialPageRoute(builder: (_) => const NavigationPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    navigateToNextPage(context);

    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/icons/amazon-icon.svg',
        ),
      ),
    );
  }
}
