import 'dart:io';

import 'package:shoe_box/constants/kcolors.dart';
import 'package:shoe_box/models/product_model.dart';
import 'package:shoe_box/providers/admin_provider.dart';
import 'package:shoe_box/utils/app_utils.dart';
import 'package:shoe_box/widgets/app_button.dart';
import 'package:shoe_box/widgets/app_text.dart';
import 'package:shoe_box/widgets/app_text_form_field.dart';
import 'package:shoe_box/widgets/custom_drop_down.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatelessWidget {
  final bool isUpdate;
  final Product? product; // if update is true
  static const String routename = '/add-product-page';

  const AddProductPage({
    super.key,
    this.isUpdate = false,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: KColors.appBarGradient,
          ),
        ),
        title: const AppText(
          'Add product',
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            productImages(adminProvider),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText('  Product name', fontWeight: FontWeight.w400),
                  const SizedBox(height: 2.0),
                  AppTextFormField(
                    controller: adminProvider.productNameController,
                    hintText: 'Enter product name',
                  ),
                  const SizedBox(height: 20.0),
                  const AppText('  Category', fontWeight: FontWeight.w400),
                  const SizedBox(height: 2.0),
                  CustomDropDown(
                    value: adminProvider.category,
                    onChanged: (value) => adminProvider.category = value,
                    items: const ['Mobiles', 'Essentials', 'Appliances', 'Books', 'Fashion'],
                  ),
                  const SizedBox(height: 20.0),
                  const AppText('  Price', fontWeight: FontWeight.w400),
                  const SizedBox(height: 2.0),
                  AppTextFormField(
                    controller: adminProvider.priceController,
                    hintText: 'Enter product price',
                    leading: const AppText('Rs.', color: Colors.black),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  const AppText('  Quantity', fontWeight: FontWeight.w400),
                  const SizedBox(height: 2.0),
                  AppTextFormField(
                    controller: adminProvider.quantityController,
                    hintText: 'Enter product quantity',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  const AppText('  Description', fontWeight: FontWeight.w400),
                  const SizedBox(height: 2.0),
                  AppTextFormField(
                    controller: adminProvider.descriptionController,
                    hintText: 'Enter product description',
                    minLines: 5,
                    maxLines: 10,
                    height: 100,
                    contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  ),
                  const SizedBox(height: 20.0),
                  AppButton(
                    onTap: () {
                      dismissKeyboard(context);
                      isUpdate
                          ? adminProvider.updateProduct(context, product!.id!)
                          : adminProvider.addProduct(context);
                    },
                    elevation: 2,
                    text: 'Save',
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productImages(AdminProvider adminProvider) {
    void pickImages() async {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        final images = adminProvider.images;
        images.addAll(result.files.map((e) => e.path!).toList());
        adminProvider.images = images;
      }
    }

    return Builder(
      builder: (context) {
        if ((product?.images ?? adminProvider.images).isNotEmpty) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                ...List.generate(
                  (product?.images ?? adminProvider.images).length,
                  (index) {
                    return Container(
                      height: 180,
                      width: 180,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: isUpdate
                            ? DecorationImage(
                                image: NetworkImage(
                                  product!.images[index],
                                ),
                              )
                            : DecorationImage(
                                image: FileImage(
                                  File(
                                    adminProvider.images[index],
                                  ),
                                ),
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isUpdate)
                            GestureDetector(
                              onTap: () {
                                final images = adminProvider.images;
                                images.remove(adminProvider.images[index]);
                                adminProvider.images = images;
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
                if (!isUpdate)
                  GestureDetector(
                    onTap: pickImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [8, 4],
                      padding: EdgeInsets.zero,
                      color: Colors.grey,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 56,
                              color: Colors.grey,
                            ),
                            AppText(
                              'Add product images',
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: pickImages,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [8, 4],
                padding: EdgeInsets.zero,
                color: Colors.grey,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0x1FC3C3C3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 56,
                        color: Colors.grey,
                      ),
                      AppText(
                        'Add product images',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
