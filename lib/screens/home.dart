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
            title: Obx(() => Text(
                  controller.currentAppbarTitle.value.toUpperCase(),
                  style: TextStyle(
                      color: theme.colorScheme.tertiary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
            actions: <Widget>[
              Obx(() => controller.selectedIndex.value == 0
                  ? IconButton(
                      icon: Icon(
                        FontAwesomeIcons.gear,
                        color: theme.colorScheme.tertiaryContainer,
                      ),
                      tooltip: "Paramètres",
                      onPressed: () {
                        Get.toNamed(AppRoutes.settings);
                      },
                    )
                  : const SizedBox.shrink())
            ],
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        Color(0xFF48C6A9),
                        Color(0xFF529FCB),
                        Color(0xFFF36D6C),
                        Color(0xFFF8AE35),
                      ],
                          stops: <double>[
                        0.0,
                        4.3,
                        7.6,
                        1.0
                      ])),
                  height: 4.0,
                ))),
        body: Navigator(
          key: controller.navigatorKey,
          onGenerateRoute: controller.activePage,
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              backgroundColor: theme.colorScheme.surfaceContainerLowest,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedIconTheme:
                  IconThemeData(color: theme.colorScheme.outline),
              selectedIconTheme:
                  IconThemeData(color: theme.colorScheme.tertiaryContainer),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.listCheck, size: 24),
                    label: "Historique"),
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
