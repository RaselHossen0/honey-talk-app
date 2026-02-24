import 'package:get/get.dart';
import 'package:tingle/page/video_call_ringing_page/controller/video_call_ringing_controller.dart';

class VideoCallRingingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallRingingController>(() => VideoCallRingingController());
  }
}
