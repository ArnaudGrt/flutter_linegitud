import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:linegitud/routes/router.dart';
import 'package:linegitud/screens/lines_list.dart';
import 'package:linegitud/screens/new_line.dart';
import 'package:linegitud/screens/history.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(1);

  final List<String> pages = [
    AppRoutes.history,
    AppRoutes.newLine,
    AppRoutes.list,
    AppRoutes.settings
  ];

  void selectMenu(int index){
    if(selectedIndex.value == index) return;

    selectedIndex.value = index;
    selectedIndex.refresh();

    Get.offNamed(pages[index], id: 1);
  }

  GetPageRoute? activePage(RouteSettings settings){
    selectedIndex.value = max(0, pages.indexOf(settings.name ?? ""));

    switch(settings.name){
      case AppRoutes.newLine:
        return GetPageRoute(
          routeName: AppRoutes.newLine,
          transition: Transition.downToUp,
          page: () => const NewLine()
        );
      case AppRoutes.list:
        return GetPageRoute(
          routeName: AppRoutes.list,
          transition: Transition.downToUp,
          page: () => const LinesList()
        );
      case AppRoutes.history:
        return GetPageRoute(
          routeName: AppRoutes.history,
          transition: Transition.downToUp,
          page: () => const History()
        );
      default:
        return GetPageRoute(
          routeName: AppRoutes.history,
          transition: Transition.downToUp,
          page: () => const History()
        );
    }
  }
}