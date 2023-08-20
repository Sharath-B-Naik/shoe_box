import 'package:shoe_box/all_product_page.dart';
import 'package:shoe_box/constants/kcolors.dart';
import 'package:shoe_box/navigation_screen.dart';
import 'package:shoe_box/providers/account_provider.dart';
import 'package:shoe_box/providers/user_provider.dart';
import 'package:shoe_box/screens/AddProduct/add_product_page.dart';
import 'package:shoe_box/screens/Auth/auth_page.dart';
import 'package:shoe_box/utils/app_utils.dart';
import 'package:shoe_box/utils/local_storage.dart';
import 'package:shoe_box/widgets/app_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: KColors.appBarGradient,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop()
            context.read<NavigationProvider>().currentIndex = 0;
          },
          splashRadius: 20,
          icon: const Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'Account Page',
              fontSize: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (_) => AccountProvider(context),
          child: Consumer2<AccountProvider, UserProvider>(
            builder: (_, accountProvider, userProvider, __) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: KColors.secondaryColor,
                          child: Icon(
                            Icons.person,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText('Sharath B Naik'),
                              AppText(
                                'https://github.com/sharath-b-naik',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AppText(
                    'Settings',
                    fontSize: 20,
                  ),
                  _ListTile(
                    leadingIcon: Icons.person,
                    title: 'Profile',
                    subtitle: 'See profile details',
                    onTap: () {},
                  ),
                  _ListTile(
                    leadingIcon: Icons.admin_panel_settings,
                    title: 'Make me admin',
                    subtitle: 'Add products as a admin',
                    onTap: () {},
                    trailingWidget: AppSwitch(
                      value: accountProvider.isAdmin,
                      onToggle: (value) {
                        accountProvider.makeAdmin(context);
                      },
                    ),
                  ),
                  _ListTile(
                    leadingIcon: Icons.shopping_cart,
                    title: 'Add Products',
                    subtitle: 'You can sell products',
                    onTap: () {
                      if (userProvider.user.type == 'admin') {
                        Navigator.pushNamed(context, AddProductPage.routename);
                      } else {
                        showSnackBar(
                          context,
                          'You are not allowed to add products',
                        );
                      }
                    },
                  ),
                  _ListTile(
                    leadingIcon: Icons.my_library_add,
                    title: 'My Products',
                    subtitle: 'See your products',
                    onTap: () {
                      if (userProvider.user.type == 'admin') {
                        Navigator.pushNamed(context, AllProductPage.routename);
                      } else {
                        showSnackBar(
                          context,
                          'You are not allowed to see products',
                        );
                      }
                    },
                  ),
                  _ListTile(
                    leadingIcon: Icons.logout,
                    title: 'Logout',
                    isLogout: true,
                    subtitle: 'You will be logged out',
                    onTap: () {
                      LocalStorage.clearAll();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AuthPage.routename,
                        (route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Widget? trailingWidget;
  final bool isLogout;
  const _ListTile({
    Key? key,
    required this.onTap,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailingWidget,
    this.isLogout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: KColors.greyBackgroundCOlor,
              child: Icon(
                leadingIcon,
                color: isLogout ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    color: isLogout ? Colors.red : Colors.black,
                  ),
                  AppText(
                    subtitle,
                    fontSize: 12,
                    color: isLogout ? Colors.red : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            trailingWidget ??
                Icon(
                  CupertinoIcons.chevron_right,
                  color: isLogout ? Colors.red : Colors.black,
                )
          ],
        ),
      ),
    );
  }
}
