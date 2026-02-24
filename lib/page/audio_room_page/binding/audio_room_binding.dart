import 'package:get/get.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';

class AudioRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioRoomController>(() => AudioRoomController());
  }
}
