import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:linegitud/bindings/home.dart';
import 'package:linegitud/routes/router.dart';
import 'package:linegitud/screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 250),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xfff0f0f0),
        useMaterial3: true,
      ),
      scrollBehavior: const MaterialScrollBehavior()
        .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: const Home(),
      getPages: AppRoutes.pages,
      initialBinding: HomeBindings(),
      initialRoute: AppRoutes.home
    );
  }
}
