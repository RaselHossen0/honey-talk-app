import 'package:get/get.dart';
import 'package:tingle/page/backpack_page/controller/backpack_controller.dart';

class BackpackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BackpackController>(() => BackpackController());
  }
}
