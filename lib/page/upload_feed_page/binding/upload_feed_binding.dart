import 'package:get/get.dart';
import 'package:tingle/page/upload_feed_page/controller/upload_feed_controller.dart';

class UploadFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadFeedController>(() => UploadFeedController());
  }
}
