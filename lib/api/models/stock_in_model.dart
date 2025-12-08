import 'dart:convert';

class StockInModel {
  final int? id;
  final int productId;
  final int quantity;
  final String date;
  final ProductModel? product;

  StockInModel({
    this.id,
    required this.productId,
    required this.quantity,
    required this.date,
    this.product,
  });

  factory StockInModel.fromJson(Map<String, dynamic> json) => StockInModel(
    id: json['id'],
    productId: json['product_id'],
    quantity: json['quantity'],
    date: json['date'],
    product: json['product'] != null
        ? ProductModel.fromJson(json['product'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'quantity': quantity,
    'date': date,
    'product': product?.toJson(),
  };

  Map<String, dynamic> toMap() => {
    'id': id,
    'productId': productId,
    'quantity': quantity,
    'date': date,
    'product': product!.toMap(),
  };
}

class ProductModel {
  final int id;
  final String name;
  final String? brand;
  final String sku;
  final String? description;
  final String price;
  final int stockQuantity;
  final List<String> images;
  final int? supplierId;
  final int? categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    this.brand,
    required this.sku,
    this.description,
    required this.price,
    required this.stockQuantity,
    required this.images,
    this.supplierId,
    this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    name: json['name'],
    brand: json['brand'],
    sku: json['sku'],
    description: json['description'],
    price: json['price'],
    stockQuantity: json['stock_quantity'],
    images: json['images'] != null
        ? List<String>.from(json['images'])
        : [],
    supplierId: json['supplier_id'],
    categoryId: json['category_id'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
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
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'stock_quantity': stockQuantity,
  };
}