import 'package:get/get.dart';

import 'package:linegitud/controllers/history.dart';
import 'package:linegitud/controllers/home.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: true);
  }
}