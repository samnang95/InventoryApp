import 'package:get/get.dart';

class ItemsController extends GetxController {
  RxString groupBy = 'None'.obs;

  void changeGroup(value) {
    groupBy.value = value;
  }

  void addItem() {
    // navigate to add item page
    Get.snackbar('Add', 'Add new item clicked');
  }

  void inviteTeam() {
    Get.snackbar('Invite', 'Invite your team clicked');
  }
}
