import 'package:get/get.dart';
import 'package:tingle/page/incoming_video_call_page/controller/incoming_video_call_controller.dart';

class IncomingVideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomingVideoCallController>(() => IncomingVideoCallController());
  }
}
