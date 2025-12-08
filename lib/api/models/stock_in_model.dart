import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/api/models/user_model.dart';

class StockInModel {
  final int? id;
  final int productId;
  final int quantity;
  final String date;
  final ProductModel? product;
  final User? creator;

  StockInModel({
    this.id,
    required this.productId,
    required this.quantity,
    required this.date,
    this.product,
    this.creator,
  });

  factory StockInModel.fromJson(Map<String, dynamic> json) => StockInModel(
    id: json['id'],
    productId: json['product_id'],
    quantity: json['quantity'],
    date: json['date'],
    product: json['product'] != null
        ? ProductModel.fromJson(json['product'])
        : null,
    creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'quantity': quantity,
    'date': date,
    'product': product?.toJson(),
    'creator': creator?.toJson(),
  };

  Map<String, dynamic> toMap() => {
    'id': id,
    'productId': productId,
    'quantity': quantity,
    'date': date,
    'product': product!.toMap(),
  };
}