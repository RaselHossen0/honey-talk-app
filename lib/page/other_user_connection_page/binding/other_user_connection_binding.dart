import 'package:get/get.dart';
import 'package:tingle/page/other_user_connection_page/controller/other_user_connection_controller.dart';

class OtherUserConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherUserConnectionController>(() => OtherUserConnectionController());
  }
}
