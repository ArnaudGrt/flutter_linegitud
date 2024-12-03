import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/settings.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final SettingsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.colorScheme.surfaceContainerLowest,
            iconTheme: IconThemeData(color: theme.colorScheme.primary),
            titleTextStyle: TextStyle(color: theme.colorScheme.onSurface),
            title: Text(
              "Paramètres",
              style: TextStyle(color: theme.colorScheme.primary),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: "Retour",
              onPressed: () {
                Get.back();
              },
            ),
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
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Thème sombre"),
                          Obx(() => Switch(
                              value: controller.isDarkMode.value,
                              onChanged: (bool value) {
                                controller.toggleThemeMode(value);
                              }))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 75,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Utilisateurs"),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 32,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
