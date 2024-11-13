import 'package:get/get.dart';
import 'package:linegitud/controllers/lines_list.dart';

class LinesListBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LinesListController(), fenix: true);
  }
}