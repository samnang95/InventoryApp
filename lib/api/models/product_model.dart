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

  ProductModel({
    this.id,
    this.name,
    this.brand,
    this.sku,
    this.description,
    this.price,
    this.stockQuantity,
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (brand != null) map['brand'] = brand;
    if (sku != null) map['sku'] = sku;
    if (description != null) map['description'] = description;
    if (price != null) map['price'] = price;
    if (stockQuantity != null) map['stock_quantity'] = stockQuantity;
    if (images != null) map['images'] = images;
    if (supplierId != null) map['supplier_id'] = supplierId;
    if (categoryId != null) map['category_id'] = categoryId;
    return map;
  }
}