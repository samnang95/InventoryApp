import 'package:inventoryapp/modules/bottom_nav/bottom_nav_page.dart';
import 'package:inventoryapp/modules/category/category_page.dart';
import 'package:inventoryapp/modules/dashboard/dashboard_page.dart';
import 'package:inventoryapp/modules/home/home_page.dart';
import 'package:inventoryapp/modules/auth/login/login_page.dart';
import 'package:inventoryapp/modules/product/product_page.dart';
import 'package:inventoryapp/modules/productDetail/productDetail_page.dart';
import 'package:inventoryapp/modules/auth/register/register_page.dart';
import 'package:inventoryapp/modules/profile/profile_page.dart';
import 'package:inventoryapp/modules/search/search_page.dart';
import 'package:inventoryapp/modules/settings/settings_page.dart';
import 'package:inventoryapp/modules/splash/splash_page.dart';
import 'package:inventoryapp/modules/transactions/transactions_page.dart';

class AppPages {
  static final pages = [
    ...SplashPage.routes,
    ...LoginPage.routes,
    ...RegisterPage.routes,
    ...HomePage.routes,
    ...ProductdetailPage.routes,
    ...SettingsPage.routes,
    ...BottomNavPage.routes,
    ...ProductPage.routes,
    ...TransactionsPage.routes,
    ...ProfilePage.routes,
    ...DashboardPage.routes,
    ...CategoryPage.routes,
    ...SearchPage.routes
  ];
}
