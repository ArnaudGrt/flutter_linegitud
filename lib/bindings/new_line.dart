import 'package:get/get.dart';
import 'package:linegitud/controllers/new_line.dart';

class NewLineBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewLineController(), fenix: true);
  }
}