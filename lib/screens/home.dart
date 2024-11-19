import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:linegitud/controllers/home.dart';
import 'package:linegitud/routes/router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();

    var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
            title: Obx(() => Text(controller.currentAppbarTitle.value,
                style: const TextStyle(
                  color: Colors.black,
                ))),
            backgroundColor: Colors.white,
            actionsIconTheme: IconThemeData(color: theme.colorScheme.primary),
            actions: <Widget>[
              IconButton(
                icon: const Icon(FontAwesomeIcons.gear),
                tooltip: "Paramètres",
                onPressed: () {
                  Get.toNamed(AppRoutes.settings);
                },
              )
            ],
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4.0),
                child: Container(
                  color: theme.colorScheme.primary,
                  height: 4.0,
                ))),
        body: Navigator(
          key: controller.navigatorKey,
          onGenerateRoute: controller.activePage,
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.listCheck, size: 24), label: "Historique"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.squarePlus, size: 24),
                    label: "Nouveau"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.rankingStar, size: 24),
                    label: "Classement"),
              ],
              currentIndex: controller.selectedIndex.value,
              onTap: controller.selectMenu,
            )));
  }
}
