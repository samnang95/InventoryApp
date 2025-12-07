class StockOutModel {
  final int? id;
  final int productId;
  final int quantity;
  final String date;

  StockOutModel({
    this.id,
    required this.productId,
    required this.quantity,
    required this.date,
  });

  factory StockOutModel.fromJson(Map<String, dynamic> json) {
    return StockOutModel(
      id: json["id"],
      productId: json["product_id"],
      quantity: json["quantity"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "date": date,
    };
  }
}