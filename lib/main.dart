import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventoryapp/app/routes/app_pages.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const InventoryApp());
}

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      initialRoute: AppRoutes.splash, // start from splash
      getPages: AppPages.pages, // ✅ Use AppPages.pages
    );
  }
}
