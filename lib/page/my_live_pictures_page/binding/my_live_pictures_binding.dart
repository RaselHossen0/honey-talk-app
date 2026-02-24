import 'package:get/get.dart';
import 'package:tingle/page/my_live_pictures_page/controller/my_live_pictures_controller.dart';

class MyLivePicturesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLivePicturesController>(() => MyLivePicturesController());
  }
}
