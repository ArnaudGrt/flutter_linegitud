import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:linegitud/routes/router.dart';
import 'package:linegitud/screens/ranking.dart';
import 'package:linegitud/screens/new_line.dart';
import 'package:linegitud/screens/history.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  final currentAppbarTitle = "Linegitud".obs;
  final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(1);

  final List<String> pages = [
    AppRoutes.history,
    AppRoutes.newLine,
    AppRoutes.ranking
  ];

  final List<String> pagesName = [
    "Linegitud",
    "Nouveau trait",
    "Classement général"
  ];

  void selectMenu(int index){
    if(selectedIndex.value == index) return;

    selectedIndex.value = index;
    selectedIndex.refresh();

    currentAppbarTitle.value = pagesName[index];
    currentAppbarTitle.refresh();

    Get.offNamed(pages[index], id: 1);
  }

  GetPageRoute? activePage(RouteSettings settings){
    selectedIndex.value = max(0, pages.indexOf(settings.name ?? ""));

    switch(settings.name){
      case AppRoutes.newLine:
        return GetPageRoute(
          routeName: AppRoutes.newLine,
          transition: Transition.downToUp,
          page: () => NewLine()
        );
      case AppRoutes.ranking:
        return GetPageRoute(
          routeName: AppRoutes.ranking,
          transition: Transition.downToUp,
          page: () => UserRanking()
        );
      case AppRoutes.history:
        return GetPageRoute(
          routeName: AppRoutes.history,
          transition: Transition.downToUp,
          page: () => History()
        );
      default:
        return GetPageRoute(
          routeName: AppRoutes.history,
          transition: Transition.downToUp,
          page: () => History()
        );
    }
  }
}