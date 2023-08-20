import 'package:shoe_box/constants/kcolors.dart';
import 'package:shoe_box/providers/user_provider.dart';
import 'package:shoe_box/widgets/app_button.dart';
import 'package:shoe_box/widgets/quantity_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserProvider>().getUserdetails(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: KColors.appBarGradient,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            SvgPicture.asset(
              'assets/icons/amazon-icon.svg',
              height: 24,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Consumer<UserProvider>(
            builder: (context, provider, child) {
              return RefreshIndicator(
                onRefresh: () async => await provider.getUserdetails(context),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      color: KColors.secondaryColor,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Expanded(
                            child: AppText(
                              'Total amount to pay',
                              color: Colors.white,
                            ),
                          ),
                          AppText(
                            'Rs. ${provider.user.cart.fold(0, (previousValue, element) => previousValue + (element.product!.price.toInt() * element.quantity!).toInt())}',
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Builder(builder: (context) {
                        if (provider.user.cart.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  size: 45,
                                  color: Colors.grey,
                                ),
                                AppText(
                                  'No Items in cart',
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: provider.user.cart.length,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 130),
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (BuildContext context, int index) {
                            final item = provider.user.cart[index];

                            return _ListTile(
                              leadingIcon: Icons.person,
                              title: (item.product?.name ?? '').toUpperCase(),
                              subtitle: item.product?.description ?? '',
                              price: (item.product?.price ?? 0).toInt(),
                              quantity: item.quantity ?? 0,
                              productimages: item.product!.images,
                              onDecrement: (value) {
                                if (value == 0) {
                                  provider.user.cart.removeWhere(
                                    (i) => i.id == item.id,
                                  );
                                  provider.updateUserDetailsFromModel(provider.user);
                                }

                                provider.modifyQuantity(
                                  context,
                                  item.product!.id!,
                                  false,
                                );
                              },
                              onIncrement: (value) {
                                provider.modifyQuantity(
                                  context,
                                  item.product!.id!,
                                  true,
                                );
                              },
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
              child: AppButton(
                text: 'Continue',
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final int quantity;
  final ValueChanged<int>? onDecrement;
  final ValueChanged<int>? onIncrement;
  final List<String> productimages;
  final IconData leadingIcon;
  final String title;
  final int price;
  final String subtitle;
  const _ListTile({
    Key? key,
    required this.quantity,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.price,
    this.onDecrement,
    this.onIncrement,
    required this.productimages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CarouselSlider(
                      items: productimages.map(
                        (i) {
                          return Builder(
                            builder: (context) => ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 400),
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(title),
                        AppText(
                          subtitle,
                          maxLines: 2,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  QuantityCounter(
                    quantity: quantity,
                    onDecrement: onDecrement,
                    onIncrement: onIncrement,
                  ),
                  Expanded(
                    child: AppText(
                      "Rs. ${price * quantity}",
                      maxLines: 2,
                      fontSize: 18,
                      textAlign: TextAlign.end,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
