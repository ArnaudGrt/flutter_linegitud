import 'package:get/get.dart';

import 'package:linegitud/controllers/history.dart';
import 'package:linegitud/controllers/home.dart';
import 'package:linegitud/controllers/new_line.dart';
import 'package:linegitud/controllers/ranking.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: true);
    Get.lazyPut(() => UserRankingController(), fenix: true);
    Get.lazyPut(() => NewLineController(), fenix: true);
  }
}