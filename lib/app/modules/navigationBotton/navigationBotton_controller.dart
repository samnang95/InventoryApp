import 'package:get/get.dart';

class NavigationbottonController {
  final selectedIndex = 0.obs;
  final username = 'User'.obs;

  void onTabSelected(int index) {
    selectedIndex.value = index;
  }
}
