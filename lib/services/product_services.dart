import 'package:shoe_box/config/secrets/secrets.dart';
import 'package:shoe_box/models/product_model.dart';
import 'package:shoe_box/utils/api_utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class ProductService {
  static Future<List<String>> uploadCloudinaryPublic(
    String productname,
    List<String> images,
  ) async {
    final cloudinaryPublic = CloudinaryPublic(cloudName, uploadPreset);
    List<String> cloudinaryImageUrls = [];
    for (final imagePath in images) {
      final cf = CloudinaryFile.fromFile(imagePath, folder: productname);
      final cloudinaryResponse = await cloudinaryPublic.uploadFile(cf);
      cloudinaryImageUrls.add(cloudinaryResponse.secureUrl);
    }

    return cloudinaryImageUrls;
  }

  static Future<ApiResponse> addProduct(Product product) async {
    List<String> cloudinaryImageUrls = await uploadCloudinaryPublic(
      product.name,
      product.images,
    );

    final response = await ApiUtils.post(
      url: '$uri/admin/product/add',
      body: product.toMap()..update('images', (_) => cloudinaryImageUrls),
    );

    return response;
  }

  static Future<ApiResponse> getProductsList() async {
    final response = await ApiUtils.get(url: '$uri/products/get');
    return response;
  }

  static Future<ApiResponse> deleteProduct(String id) async {
    final response = await ApiUtils.post(
      url: '$uri/admin/product/delete',
      body: {"id": id},
    );

    return response;
  }

  static Future<dynamic> updateProduct(Product product) async {
    final response = await ApiUtils.post(
      url: '$uri/admin/product/update',
      body: product.toMap(),
    );

    return response;
  }
}
