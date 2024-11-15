import 'package:get/get.dart';
import 'package:linegitud/controllers/history.dart';

class HistoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(() => HistoryController());
  }
}