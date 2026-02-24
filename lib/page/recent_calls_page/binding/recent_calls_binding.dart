import 'package:get/get.dart';
import 'package:tingle/page/recent_calls_page/controller/recent_calls_controller.dart';

class RecentCallsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentCallsController>(() => RecentCallsController());
  }
}
