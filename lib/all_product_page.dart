import 'package:shoe_box/constants/kcolors.dart';
import 'package:shoe_box/providers/admin_provider.dart';
import 'package:shoe_box/providers/product_provider.dart';
import 'package:shoe_box/screens/AddProduct/add_product_page.dart';
import 'package:shoe_box/widgets/app_button.dart';
import 'package:shoe_box/widgets/app_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AllProductPage extends StatefulWidget {
  static const String routename = 'all-product-page';
  const AllProductPage({Key? key}) : super(key: key);

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().getProductsList(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = context.watch<AdminProvider>();

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
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/amazon-icon.svg',
                  height: 24,
                ),
                const Spacer(),
                const AppButton(
                  width: 60,
                  height: 35,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  text: "Admin",
                )
              ],
            ),
          ],
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 3));
              await productProvider.getProductsList(context);
            },
            child: GridView.builder(
              itemCount: productProvider.productlists?.length ?? 0,
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (BuildContext context, int index) {
                final product = productProvider.productlists![index];
                return Card(
                  color: const Color.fromARGB(255, 234, 232, 232),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CarouselSlider.builder(
                              itemCount: product.images.length,
                              itemBuilder: (_, index, __) {
                                return Image.network(
                                  product.images[index],
                                  fit: BoxFit.contain,
                                );
                              },
                              options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlay: true,
                                autoPlayAnimationDuration: const Duration(
                                  milliseconds: 200,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 8.0),
                          child: AppText(
                            product.name,
                            fontSize: 18,
                            color: Colors.black,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                          child: AppText(
                            'Rs. ${product.price.toInt()}',
                            maxLines: 1,
                            color: KColors.selectedNavBarColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AppButton(
                                onTap: () {
                                  adminProvider.setFormDataIfUpdate(product);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddProductPage(
                                        isUpdate: true,
                                        product: product,
                                      ),
                                    ),
                                  );
                                },
                                text: 'Update',
                                height: 30,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: AppButton(
                                onTap: () {
                                  if (!product.isDeleting) {
                                    adminProvider.deleteProduct(
                                      context,
                                      product.id!,
                                    );
                                  }
                                },
                                text: product.isDeleting ? null : 'Delete',
                                height: 30,
                                fontSize: 10,
                                backgroundColor: Colors.red,
                                child: product.isDeleting
                                    ? const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: KColors.secondaryColor,
        elevation: 10,
        child: const Icon(Icons.add),
        onPressed: () {
          // productProvider.clearAddProductForm();
          Navigator.pushNamed(context, AddProductPage.routename);
        },
      ),
    );
  }
}
