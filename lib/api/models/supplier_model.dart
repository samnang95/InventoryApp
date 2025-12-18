class SupplierModel {
  final int? id;
  final String name;
  final String? contactInfo;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  SupplierModel({
    this.id,
    required this.name,
    this.contactInfo,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      name: json['name'] ?? '',
      contactInfo: json['contact_info'],
      address: json['address'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "contact_info": contactInfo,
    "address": address,
  };
}