class Product {
  final String? id;
  final String userid;
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  bool isDeleting = false;

  Product({
    this.id,
    required this.userid,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.isDeleting = false,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user_id': userid,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'],
      userid: map['user_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }
}
