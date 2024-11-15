import 'package:get/get.dart';
import 'package:linegitud/controllers/ranking.dart';

class UserRankingBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserRankingController(), fenix: true);
  }
}