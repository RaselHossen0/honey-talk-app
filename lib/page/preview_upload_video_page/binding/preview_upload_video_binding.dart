import 'package:get/get.dart';
import 'package:tingle/page/preview_upload_video_page/controller/preview_upload_video_controller.dart';

class PreviewUploadVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewUploadVideoController>(() => PreviewUploadVideoController());
  }
}
