import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linegitud/bindings/home.dart';

import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/controllers/settings.dart';
import 'package:linegitud/env/theme.dart';
import 'package:linegitud/routes/router.dart';
import 'package:linegitud/screens/home.dart';
import 'package:linegitud/screens/loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDarkMode = await SettingsController.getThemeMode();

  runApp(
    App(
      isDarkMode: isDarkMode
    )
  );
}

class App extends StatelessWidget {
  const App({
    super.key, 
    required this.isDarkMode
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DataBaseController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 250),
      theme: LinegitudTheme.lightTheme,
      darkTheme: LinegitudTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: Obx(
          () => controller.initLoading.value ? const Loader() : const Home()),
      getPages: AppRoutes.pages,
      initialBinding: HomeBindings(),
    );
  }
}
