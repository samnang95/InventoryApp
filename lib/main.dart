import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventoryapp/app/controllers/ratio_controller.dart';
import 'package:inventoryapp/app/controllers/theme_controller.dart';
import 'package:inventoryapp/app/modules/inventory/inventory_controller.dart';
import 'package:inventoryapp/app/routes/app_pages.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ThemeController(), permanent: true);
  Get.put(RatioController());
  Get.put(InventoryController());
  runApp(InventoryApp());
}

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Inventory App',
          theme: Get.find<ThemeController>().theme,
          initialRoute: AppRoutes.splash, // start from splash
          getPages: AppPages.pages, // ✅ Use AppPages.pages
        );
      },
    );
  }
}
