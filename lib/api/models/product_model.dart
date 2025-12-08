import 'package:inventoryapp/api/models/user_model.dart';

class ProductModel {
  final int? id;
  final String? name;
  final String? brand;
  final String? sku;
  final String? description;
  final double? price;
  final int? stockQuantity;
  final List<String>? images;
  final int? supplierId;
  final int? categoryId;
  final Map<String, dynamic>? supplier;
  final Map<String, dynamic>? category;
  final User? creator;

  ProductModel({
    this.id,
    this.name,
    this.brand = '',
    this.sku = '',
    this.description = '',
    this.price = 0.0,
    this.stockQuantity = 0,
    List<String>? images,
    this.supplierId,
    this.categoryId = 0,
    Map<String, dynamic>? supplier,
    Map<String, dynamic>? category,
    this.creator,
  })  : images = images ?? [],
        supplier = supplier ?? {},
        category = category ?? {};

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      stockQuantity: json['stock_quantity'] ?? 0,
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      supplierId: json['supplier_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      supplier: json['supplier'] ?? {},
      category: json['category'] ?? {},
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'sku': sku,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'images': images,
      'supplier_id': supplierId,
      'category_id': categoryId,
      'supplier': supplier,
      'category': category,
      'creator': creator?.toJson(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'sku': sku,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'images': images?.join(',') ?? '',
      'supplier_id': supplierId,
      'category_id': categoryId,
    };
  }
}