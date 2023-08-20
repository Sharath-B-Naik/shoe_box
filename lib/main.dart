import 'package:shoe_box/config/routes/route_config.dart';
import 'package:shoe_box/navigation_screen.dart';
import 'package:shoe_box/providers/admin_provider.dart';
import 'package:shoe_box/providers/auth_provider.dart';
import 'package:shoe_box/providers/product_provider.dart';
import 'package:shoe_box/providers/user_provider.dart';
import 'package:shoe_box/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Amazon Clone Admin ',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
