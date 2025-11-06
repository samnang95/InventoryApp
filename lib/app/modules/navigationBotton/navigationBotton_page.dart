import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/app/modules/navigationBotton/navigationBotton_route.dart';

class NavigationbottonPage {
  static final pages = [
    GetPage(
      name: NavigationbottonRoute.home,
      page: () => const Scaffold(),
      binding: null,
    ),
  ];
}
