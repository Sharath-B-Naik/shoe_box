import 'package:shoe_box/constants/kcolors.dart';
import 'package:shoe_box/providers/auth_provider.dart';
import 'package:shoe_box/widgets/app_button.dart';
import 'package:shoe_box/widgets/app_text.dart';
import 'package:shoe_box/widgets/app_text_form_field.dart';
import 'package:shoe_box/widgets/expandable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../navigation_screen.dart';

class AuthPage extends StatelessWidget {
  static const String routename = '/auth-page';
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.greyBackgroundCOlor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/amazon-icon.svg',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const AppText(
                      'Welcome',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              ListTile(
                // tileColor: authProvider.auth == Auth.signup ? KColors.backgroundColor : KColors.greyBackgroundCOlor,
                tileColor: KColors.greyBackgroundCOlor,
                title: const AppText(
                  'Create Account',
                  fontWeight: FontWeight.bold,
                ),
                leading: Radio(
                  activeColor: KColors.secondaryColor,
                  value: Auth.signup,
                  groupValue: true,
                  onChanged: (val) {
                    // authProvider.auth = val!;
                  },
                ),
              ),
              AppExpansionTile(
                // expand: authProvider.auth == Auth.signup,
                expand: true,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: KColors.backgroundColor,
                  child: Column(
                    children: [
                      const AppTextFormField(
                        // controller: authProvider.nameController,
                        hintText: 'Name',
                      ),
                      const SizedBox(height: 20),
                      const AppTextFormField(
                        // controller: authProvider.emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      const AppTextFormField(
                        // controller: authProvider.passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        text: 'Sign Up',
                        // onTap: () => authProvider.signUpUser(context),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            NavigationPage.routename,
                            (route) => false,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                // tileColor: authProvider.auth == Auth.signin ? KColors.backgroundColor : KColors.greyBackgroundCOlor,
                tileColor: KColors.greyBackgroundCOlor,
                title: const AppText(
                  'Sign-In.',
                  fontWeight: FontWeight.bold,
                ),
                leading: Radio(
                  activeColor: KColors.secondaryColor,
                  value: Auth.signin,
                  // groupValue: authProvider.auth,
                  groupValue: true,
                  onChanged: (val) {
                    // authProvider.auth = val!;
                  },
                ),
              ),
              AppExpansionTile(
                expand: true,
                // expand: authProvider.auth == Auth.signin,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: KColors.backgroundColor,
                  child: Column(
                    children: [
                      const AppTextFormField(
                        // controller: authProvider.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      const AppTextFormField(
                        // controller: authProvider.passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 10),
                      AppButton(
                        text: 'Sign In',
                        // onTap: () => authProvider.signInUser(context),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            NavigationPage.routename,
                            (route) => false,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
