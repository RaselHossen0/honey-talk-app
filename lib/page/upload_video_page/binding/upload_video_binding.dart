import 'package:get/get.dart';
import 'package:tingle/page/upload_video_page/controller/upload_video_controller.dart';

class UploadVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadVideoController>(() => UploadVideoController());
  }
}
