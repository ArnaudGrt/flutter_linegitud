import 'package:get/get.dart';
import 'package:linegitud/env/theme.dart';
import 'package:linegitud/utils/storage.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;

  @override
  void onInit(){
    initThemeMode();

    super.onInit();
  }

  Future<void> initThemeMode() async {
    isDarkMode.value = await getThemeMode();
  }

  Future<void> toggleThemeMode(value) async {
    isDarkMode.value = value;
    await setThemeMode(value);

    Get.changeTheme(isDarkMode.value ? LinegitudTheme.darkTheme : LinegitudTheme.lightTheme);
  }

  static Future<bool> getThemeMode() async {
    return await Storage.getBool("darkMode") ?? false;
  }

  static Future<bool> setThemeMode(bool isDarkMode) async {
    return await Storage.setBool("darkMode", isDarkMode);
  }
}