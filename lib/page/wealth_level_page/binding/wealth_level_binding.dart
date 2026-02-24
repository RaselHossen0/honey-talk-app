import 'package:get/get.dart';
import 'package:tingle/page/wealth_level_page/controller/wealth_level_controller.dart';

class WealthLevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WealthLevelController>(() => WealthLevelController());
  }
}
