// lib/models/product_model.dart
class ProductModel {
  final String id;
  final String name;
  final int price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  /// Konversi object ke Map (untuk disimpan ke database / json)
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'image': image};
  }

  /// Konversi Map ke object ProductModel
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      image: map['image'] ?? '',
    );
  }
}
