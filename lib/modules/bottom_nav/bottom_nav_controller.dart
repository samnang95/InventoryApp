import 'package:get/get.dart';

class BottomNavController extends GetxController {

  var selectedIndex = 0.obs;
  var username = 'User'.obs;

  void onTabSelected(int index) {
    selectedIndex.value = index;
  }
}