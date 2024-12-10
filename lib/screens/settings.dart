import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/settings.dart';
import 'package:linegitud/routes/router.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final SettingsController controller = Get.find();
  final popKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final WidgetStateProperty<Icon?> switchIcon =
        WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }

      return const Icon(Icons.close);
    });

    return PopScope(
        key: popKey,
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Get.back();
          Get.offAllNamed(AppRoutes.home, id: 1);
        },
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: theme.colorScheme.surfaceContainerLowest,
                iconTheme:
                    IconThemeData(color: theme.colorScheme.tertiaryContainer),
                title: Text("Paramètres".toUpperCase(),
                    style: TextStyle(
                        color: theme.colorScheme.tertiary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                leading: IconButton(
                  highlightColor: theme.colorScheme.onTertiary,
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: "Retour",
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed(AppRoutes.home, id: 1);
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
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 16, bottom: 16),
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                                color: theme.colorScheme.inverseSurface)),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(FontAwesomeIcons.moon,
                              size: 16,
                              color: theme.colorScheme.inverseSurface),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      const Text("Dark Mode"),
                      const Spacer(),
                      Obx(() => Switch(
                          activeColor: theme.colorScheme.tertiary,
                          thumbIcon: switchIcon,
                          value: controller.isDarkMode.value,
                          onChanged: (bool value) {
                            controller.toggleThemeMode(value);
                          }))
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 24),
                          child: Text(
                            "Utilisateurs",
                            style: TextStyle(
                                color: theme.colorScheme.inverseSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      overlayColor: WidgetStatePropertyAll<Color>(
                          theme.colorScheme.surface),
                      onTap: () {
                        Get.toNamed(AppRoutes.users);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  border: Border.all(
                                      color: theme.colorScheme.inverseSurface)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(FontAwesomeIcons.user,
                                    size: 16,
                                    color: theme.colorScheme.inverseSurface),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            const Text("Gestion"),
                            const Spacer(),
                            Icon(FontAwesomeIcons.angleRight,
                                size: 16,
                                color: theme.colorScheme.inverseSurface),
                          ]),
                    )
                  ],
                ))));
  }
}
