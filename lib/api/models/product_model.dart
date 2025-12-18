import 'package:inventoryapp/api/models/user_model.dart';
import 'package:inventoryapp/api/models/supplier_model.dart';
import 'package:inventoryapp/api/models/category_model.dart';

class ProductModel {
  final int? id;
  final String? name;
  final String? brand;
  final String? sku;
  final String? description;
  final double? price;
  final int? stockQuantity;
  final String? image;
  final int? supplierId;
  final int? categoryId;
  final SupplierModel? supplier; // Use Supplier model
  final CategoryModel? category; // Use Category model
  final User? creator;

  ProductModel({
    this.id,
    this.name,
    this.brand = '',
    this.sku = '',
    this.description = '',
    this.price = 0.0,
    this.stockQuantity = 0,
    this.image = '',
    this.supplierId,
    this.categoryId = 0,
    this.supplier,
    this.category,
    this.creator,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      stockQuantity: json['stock_quantity'] is int
          ? json['stock_quantity']
          : int.tryParse(json['stock_quantity']?.toString() ?? '0') ?? 0,
      image: json['image'] ?? '',
      supplierId: json['supplier_id'] is int
          ? json['supplier_id']
          : int.tryParse(json['supplier_id']?.toString() ?? ''),
      categoryId: json['category_id'] is int
          ? json['category_id']
          : int.tryParse(json['category_id']?.toString() ?? '0') ?? 0,
      supplier: json['supplier'] != null
          ? SupplierModel.fromJson(json['supplier'])
          : null,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      creator:
      json['creator'] != null ? User.fromJson(json['creator']) : null,
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
      'image': image,
      'supplier_id': supplierId,
      'category_id': categoryId,
      'supplier': supplier?.toJson(),
      'category': category?.toJson(),
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
      'image': image,
      'supplier_id': supplierId,
      'category_id': categoryId,
    };
  }
}