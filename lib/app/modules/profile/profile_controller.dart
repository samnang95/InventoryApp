import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = 'Samnang'.obs;

  void updateUsername(String newName) {
    username.value = newName;
  }
}
