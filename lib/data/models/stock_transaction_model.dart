class StockTransactionModel {
  final String itemId;
  final String itemName;
  final int quantity;
  final String unit;
  final DateTime date;
  final String location;
  final String type; // "Stock In" or "Stock Out"
  final String? supplierOrCustomer;
  final double? price;
  final String? batchNumber;
  final String? notes;

  StockTransactionModel({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.unit,
    required this.date,
    required this.location,
    required this.type,
    this.supplierOrCustomer,
    this.price,
    this.batchNumber,
    this.notes,
  });
}