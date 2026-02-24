import 'package:get/get.dart';
import 'package:tingle/page/feed_square_page/controller/feed_square_controller.dart';

class FeedSquareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedSquareController>(() => FeedSquareController());
  }
}
