class StockInModel {
  int? id;
  int productId;
  int quantity;
  String date;

  StockInModel({
    this.id,
    required this.productId,
    required this.quantity,
    required this.date,
  });

  factory StockInModel.fromJson(Map<String, dynamic> json) => StockInModel(
    id: json['id'],
    productId: json['product_id'],
    quantity: json['quantity'],
    date: json['date'],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
    "date": date,
  };
}