import 'package:get/get.dart';
import 'package:tingle/page/feed_video_page/controller/feed_video_controller.dart';

class FeedVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedVideoController>(() => FeedVideoController());
  }
}
