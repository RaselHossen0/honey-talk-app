import 'package:get/get.dart';
import 'package:tingle/page/my_profile_page/controller/my_profile_controller.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}
