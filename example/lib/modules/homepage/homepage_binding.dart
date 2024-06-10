import 'package:flutter_nuvei_simply_connect_test_example/modules/homepage/homepage_controller.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(
      HomePageController(),
    );
  }
}
