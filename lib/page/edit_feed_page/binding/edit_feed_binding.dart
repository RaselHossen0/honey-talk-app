import 'package:get/get.dart';
import 'package:tingle/page/edit_feed_page/controller/edit_feed_controller.dart';

class EditFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditFeedController>(() => EditFeedController());
  }
}
