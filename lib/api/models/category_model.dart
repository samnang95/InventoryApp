class CategoryModel {
  final int? id;
  final String name;
  final String? description;

  CategoryModel({
    this.id,
    required this.name,
    this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
  };
}