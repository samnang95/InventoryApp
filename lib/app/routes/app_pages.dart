import 'package:inventoryapp/app/modules/home/home_page.dart';
import 'package:inventoryapp/app/modules/inventory/inventory_page.dart';
import 'package:inventoryapp/app/modules/login/login_page.dart';
import 'package:inventoryapp/app/modules/navigationBotton/navigationBotton_page.dart';
import 'package:inventoryapp/app/modules/register/register_page.dart';
import 'package:inventoryapp/app/modules/splash/splash_page.dart';
import 'package:inventoryapp/app/modules/transactions/transactions_page.dart';

class AppPages {
  static final pages = [
    // Splash
    ...SplashPage.routes,

    // Auth
    ...LoginPage.routes,
    ...RegisterPage.routes,

    //Home
    ...HomePage.routes,

    // Navigation Route
    ...NavigationbottonPage.routes,
    ...InventoryPage.routes,
    ...TransactionsPage.routes,
  ];
}
