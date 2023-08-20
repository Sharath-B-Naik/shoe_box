import 'package:shoe_box/models/product_model.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? address;
  final String? type;
  final String? token;
  final List<CartItems> cart;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.address,
    this.type,
    this.token,
    this.cart = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List.from(map['cart'] ?? []).map((e) => CartItems.fromMap(e)).toList(),
    );
  }

  // copywith
  UserModel copywith({
    String? id,
    String? name,
    String? email,
    String? token,
    String? password,
    String? address,
    String? type,
    List<CartItems>? cart,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      cart: cart ?? this.cart,
    );
  }
}

class CartItems {
  final String? id;
  final int? quantity;
  final Product? product;

  CartItems({this.id, this.quantity, this.product});

  factory CartItems.fromMap(Map<String, dynamic> map) {
    return CartItems(
      id: map['_id'] ?? '',
      quantity: map['quantity'] ?? 0,
      product: Product.fromMap(map['product']),
    );
  }
}
