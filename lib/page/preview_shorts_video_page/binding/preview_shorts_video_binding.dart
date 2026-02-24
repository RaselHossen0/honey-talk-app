import 'package:get/get.dart';
import 'package:tingle/page/preview_shorts_video_page/controller/preview_shorts_video_controller.dart';

class PreviewShortsVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewShortsVideoController>(() => PreviewShortsVideoController());
  }
}
