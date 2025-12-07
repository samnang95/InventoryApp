// lib/api/models/product_model.dart
class ProductModel {
  final int? id;
  final String name;
  final String brand;
  final String? sku;
  final String description;
  final double price;
  final int stockQuantity;
  final List<String>? images;
  final int? supplierId;
  final int? categoryId;
  final Map<String, dynamic>? supplier;
  final Map<String, dynamic>? category;

  ProductModel({
    this.id,
    required this.name,
    required this.brand,
    this.sku,
    required this.description,
    required this.price,
    required this.stockQuantity,
    this.images,
    this.supplierId,
    this.categoryId,
    this.supplier,
    this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0,
      stockQuantity: json['stock_quantity'] ?? 0,
      images: (json['images'] as List?)?.cast<String>() ?? [],
      supplierId: json['supplier_id'],
      categoryId: json['category_id'],
      supplier: json['supplier'] ?? {},
      category: json['category'] ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'brand': brand,
    'sku': sku,
    'description': description,
    'price': price,
    'stock_quantity': stockQuantity,
    'images': images,
    'supplier_id': supplierId,
    'category_id': categoryId,
  };
}