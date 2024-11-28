import 'package:get/get.dart';
import 'package:linegitud/controllers/db.dart';

class DataBaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataBaseController(), fenix: true);
  }
}