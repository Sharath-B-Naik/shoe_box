import 'package:shoe_box/constants/kcolors.dart';
import 'package:shoe_box/screens/Account/account_page.dart';
import 'package:shoe_box/screens/Cart/cart_page.dart';
import 'package:shoe_box/screens/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class NavigationPage extends StatelessWidget {
  static const String routename = "/navigation-page";
  const NavigationPage({Key? key}) : super(key: key);

  static List<Widget> get screens => [
        const HomePage(),
        const CartPage(),
        const AccountPage(),
      ];

  static List<IconData> get icons => [
        Icons.home_rounded,
        Icons.shopping_cart,
        Icons.account_circle,
      ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProvider>();
    return WillPopScope(
      onWillPop: () async {
        if (navigationProvider.currentIndex == 0) {
          return true;
        } else {
          navigationProvider.currentIndex = 0;
          return false;
        }
      },
      child: Scaffold(
        extendBody: true,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          switchInCurve: Curves.easeInOutBack,
          child: Builder(
            key: ValueKey(navigationProvider.currentIndex),
            builder: (_) => screens[navigationProvider.currentIndex],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF555E58).withOpacity(0.09),
                blurRadius: 15,
                offset: const Offset(2, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: Row(
              children: List.generate(
                icons.length,
                (index) {
                  return Expanded(
                    child: Material(
                      color: Colors.transparent,
                      type: MaterialType.circle,
                      child: InkWell(
                        onTap: () {
                          navigationProvider.currentIndex = index;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              size: navigationProvider.currentIndex == index ? 36 : 28,
                              color: navigationProvider.currentIndex == index
                                  ? KColors.selectedNavBarColor
                                  : KColors.unselectedNavBarColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
