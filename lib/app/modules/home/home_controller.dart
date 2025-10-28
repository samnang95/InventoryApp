import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  final username = 'User'.obs;

  void onTabSelected(int index) {
    selectedIndex.value = index;
  }
}
