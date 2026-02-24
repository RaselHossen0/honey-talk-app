import 'package:get/get.dart';
import 'package:tingle/page/charming_level_page/controller/charming_level_controller.dart';

class CharmingLevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CharmingLevelController>(() => CharmingLevelController());
  }
}
