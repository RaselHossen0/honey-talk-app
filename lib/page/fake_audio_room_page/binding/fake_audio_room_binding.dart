import 'package:get/get.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';

class FakeAudioRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FakeAudioRoomController>(() => FakeAudioRoomController());
  }
}
