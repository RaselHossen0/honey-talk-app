import 'package:get/get.dart';
import 'package:tingle/page/feed_follow_page/controller/feed_follow_controller.dart';

class FeedFollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedFollowController>(() => FeedFollowController());
  }
}
