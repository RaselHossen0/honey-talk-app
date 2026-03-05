import 'package:get/get.dart';
import 'package:tingle/page/task_page/controller/task_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}
