import 'package:shoe_box/models/product_model.dart';
import 'package:shoe_box/providers/product_provider.dart';
import 'package:shoe_box/providers/user_provider.dart';
import 'package:shoe_box/services/product_services.dart';
import 'package:shoe_box/utils/app_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AdminProvider extends ChangeNotifier {
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();

  List<String> _images = [];
  List<String> get images => _images;
  set images(List<String> data) {
    _images = data;
    notifyListeners();
  }

  String? _category;
  String? get category => _category;
  set category(String? data) {
    _category = data;
    notifyListeners();
  }

  void addProduct(BuildContext context) async {
    final productName = productNameController.text.trim();
    final price = priceController.text.trim();
    final quantity = quantityController.text.trim();
    final description = descriptionController.text.trim();

    if (images.isEmpty) return showSnackBar(context, 'Please select images');
    if (productName.isEmpty) return showSnackBar(context, 'Enter product name');
    if (category == null) return showSnackBar(context, 'Select category');
    if (price.isEmpty) return showSnackBar(context, 'Enter price');
    if (quantity.isEmpty) return showSnackBar(context, 'Enter quantity');
    if (description.isEmpty) return showSnackBar(context, 'Enter description');

    final product = Product(
      userid: context.read<UserProvider>().user.id!,
      name: productName,
      description: description,
      quantity: double.tryParse(quantity) ?? 0.0,
      images: images,
      category: category!,
      price: double.tryParse(price) ?? 0.0,
    );

    try {
      showLoading(context);
      final resp = await ProductService.addProduct(product);

      stopLoading(context);
      if (resp.data != null) {
        showSnackBar(context, 'Product added successfully');
        Navigator.of(context).pop();
        clearAddProductForm();
        context.read<ProductProvider>().getProductsList(context);
      } else {
        showSnackBar(context, resp.error!);
      }
    } catch (e) {
      stopLoading(context);
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct(BuildContext context, String id) async {
    // For show loading indicator of deleting.
    final productProvider = context.read<ProductProvider>();
    productProvider.productlists = productProvider.productlists?.map<Product>((item) {
      if (item.id == id) {
        item.isDeleting = true;
        return item;
      } else {
        return item;
      }
    }).toList();

    try {
      final resp = await ProductService.deleteProduct(id);
      if (resp.data != null) {
        showSnackBar(context, 'Product deleted successfully');
        productProvider.productlists?.removeWhere((item) => item.id == id);
        notifyListeners();
      } else {
        productProvider.productlists = [];
        showSnackBar(context, resp.error!);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void setFormDataIfUpdate(Product product) {
    productNameController.text = product.name;
    priceController.text = product.price.toString();
    quantityController.text = product.quantity.toString();
    descriptionController.text = product.description;
    category = product.category;
    images = product.images;
  }

  void updateProduct(BuildContext context, String id) async {
    final productName = productNameController.text.trim();
    final price = priceController.text.trim();
    final quantity = quantityController.text.trim();
    final description = descriptionController.text.trim();

    if (images.isEmpty) return showSnackBar(context, 'Please select images');
    if (productName.isEmpty) return showSnackBar(context, 'Enter product name');
    if (category == null) return showSnackBar(context, 'Select category');
    if (price.isEmpty) return showSnackBar(context, 'Enter price');
    if (quantity.isEmpty) return showSnackBar(context, 'Enter quantity');
    if (description.isEmpty) return showSnackBar(context, 'Enter description');

    final product = Product(
      id: id,
      userid: context.read<UserProvider>().user.id!,
      name: productName,
      description: description,
      quantity: double.tryParse(quantity) ?? 0.0,
      images: images,
      category: category!,
      price: double.tryParse(price) ?? 0.0,
    );

    try {
      showLoading(context);
      final resp = await ProductService.updateProduct(product);
      stopLoading(context);
      if (resp != null) {
        showSnackBar(context, 'Product updated successfully');
        Navigator.of(context).pop();
        clearAddProductForm();
        context.read<ProductProvider>().getProductsList(context);
      }
    } catch (e) {
      stopLoading(context);
      showSnackBar(context, e.toString());
    }
  }

  void clearAddProductForm() {
    productNameController.clear();
    priceController.clear();
    quantityController.clear();
    descriptionController.clear();
    images.clear();
    category = null;
  }

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
