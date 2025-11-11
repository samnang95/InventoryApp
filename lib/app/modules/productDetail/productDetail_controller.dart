import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  RxInt currentImage = 0.obs;

  List<String> images = [
    "assets/images/s1.jpg",
    "assets/images/s2.jpg",
    "assets/images/s3.png",
  ];
}
