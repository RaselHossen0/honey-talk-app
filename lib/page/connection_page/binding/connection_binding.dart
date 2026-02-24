import 'package:get/get.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionController>(() => ConnectionController());
  }
}
