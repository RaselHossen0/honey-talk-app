import 'package:get/get.dart';
import 'package:tingle/page/report_page/controller/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController());
  }
}
