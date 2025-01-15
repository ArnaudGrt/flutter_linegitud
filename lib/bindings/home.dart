import 'package:get/get.dart';

import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/controllers/history.dart';
import 'package:linegitud/controllers/home.dart';
import 'package:linegitud/controllers/line.dart';
import 'package:linegitud/controllers/new_line.dart';
import 'package:linegitud/controllers/ranking.dart';
import 'package:linegitud/controllers/settings.dart';
import 'package:linegitud/controllers/users.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => UsersController(), fenix: true);
    Get.lazyPut(() => DataBaseController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: true);
    Get.lazyPut(() => UserRankingController(), fenix: true);
    Get.lazyPut(() => NewLineController(), fenix: true);
    Get.lazyPut(() => LineController(), fenix: true);
  }
}