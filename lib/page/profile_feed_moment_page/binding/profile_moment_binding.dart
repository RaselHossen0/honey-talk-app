import 'package:get/get.dart';
import 'package:tingle/page/profile_feed_moment_page/controller/profile_moment_controller.dart';

class ProfileMomentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileMomentController>(() => ProfileMomentController());
  }
}
