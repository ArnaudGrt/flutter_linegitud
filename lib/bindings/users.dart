import 'package:get/get.dart';
import 'package:linegitud/controllers/users.dart';

class UsersBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersController(), fenix: true);
  }
}