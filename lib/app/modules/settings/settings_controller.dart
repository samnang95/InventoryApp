import 'package:get/get.dart';

class SettingsController extends GetxController {
  void navigate(String pageName) {
    Get.snackbar("Navigate", "Go to $pageName page");
  }
}
