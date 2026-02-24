import 'package:get/get.dart';
import 'package:tingle/page/create_audio_room_page/controller/create_audio_room_controller.dart';

class CreateAudioRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAudioRoomController>(() => CreateAudioRoomController());
  }
}
