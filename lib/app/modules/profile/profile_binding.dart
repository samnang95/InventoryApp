import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.lazyPut<ProfileController>(() => ProfileController());
    Get.put(ProfileController());
  }
}
