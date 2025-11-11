import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  var selectedCategory = ''.obs;
  var selectedBrand = ''.obs;

  List<String> categories = ["Electronics", "Clothes", "Food", "Other"];
  List<String> brands = ["Samsung", "Apple", "Adidas", "Local"];
}
