import 'package:get/get.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';

class PartyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
