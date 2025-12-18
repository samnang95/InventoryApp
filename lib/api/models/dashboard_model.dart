class DashboardSummary {
  final int totalProducts;
  final int totalCategories;
  final int totalSuppliers;
  final int totalStaff;
  final int lowStock;

  DashboardSummary({
    required this.totalProducts,
    required this.totalCategories,
    required this.totalSuppliers,
    required this.totalStaff,
    required this.lowStock,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalProducts: json['total_products'] ?? 0,
      totalCategories: json['total_categories'] ?? 0,
      totalSuppliers: json['total_suppliers'] ?? 0,
      totalStaff: json['total_staff'] ?? 0,
      lowStock: json['low_stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "total_products": totalProducts,
    "total_categories": totalCategories,
    "total_suppliers": totalSuppliers,
    "total_staff": totalStaff,
    "low_stock": lowStock,
  };
}

class DashboardUser {
  final int id;
  final String name;
  final String email;
  final String role;
  final String avatar;

  DashboardUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatar,
  });

  factory DashboardUser.fromJson(Map<String, dynamic> json) {
    return DashboardUser(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "avatar": avatar,
  };
}

class DashboardModel {
  final DashboardSummary summary;
  final DashboardUser user;

  DashboardModel({
    required this.summary,
    required this.user,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      summary: DashboardSummary.fromJson(json['summary']),
      user: DashboardUser.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
    "summary": summary.toJson(),
    "user": user.toJson(),
  };
}