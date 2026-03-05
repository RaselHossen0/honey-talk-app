import 'package:get/get.dart';
import 'package:tingle/page/live_end_page/controller/live_end_controller.dart';

class LiveEndBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveEndController>(() => LiveEndController());
  }
}
