import 'package:get/get.dart';
import 'package:linegitud/controllers/settings.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}