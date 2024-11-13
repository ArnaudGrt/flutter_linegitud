import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text(
          "Linegitud",
          style: TextStyle(
            color: Colors.black,
          )
        ),
        backgroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(
          color: Colors.black
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
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
          )
        )
      ),
      body: Navigator(
        key: controller.navigatorKey,
        onGenerateRoute: controller.activePage,
      ),
      bottomNavigationBar: Obx( 
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24),
              label: "Accueil"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, size: 24),
              label: "Nouveau trait"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list, size: 24),
              label: "Liste des traits"
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          onTap: controller.selectMenu,
        )
      )
    );
  }
}