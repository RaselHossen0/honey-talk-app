import 'package:get/get.dart';
import 'package:tingle/page/edit_video_page/controller/edit_video_controller.dart';

class EditVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVideoController>(() => EditVideoController());
  }
}
