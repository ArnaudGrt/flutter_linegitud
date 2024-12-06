import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:linegitud/controllers/history.dart';
import 'package:linegitud/controllers/home.dart';
import 'package:linegitud/models/line.dart';

class History extends StatelessWidget {
  History({super.key});

  final HistoryController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => showContent());
  }

  Widget showContent() {
    var theme = Theme.of(Get.context!);

    if (controller.isLoading.value) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.tertiaryContainer,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: RefreshIndicator(
                color: theme.colorScheme.onInverseSurface,
                backgroundColor: theme.colorScheme.tertiary,
                onRefresh: () async {
                  return controller.refreshLinesHistory();
                },
                notificationPredicate: defaultScrollNotificationPredicate,
                child: Obx(() => controller.linesHistoryEmpty()
                    ? CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              children: [
                                Expanded(
                                    child: Center(
                                        child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.faceSadTear,
                                      size: 120,
                                      color:
                                          theme.colorScheme.tertiaryContainer,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                          "Aucun trait n'a encore été ajouté...",
                                          style: TextStyle(
                                              color:
                                                  theme.colorScheme.onSurface,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: ElevatedButton.icon(
                                            onPressed: () {
                                              homeController.selectMenu(1);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: theme
                                                    .colorScheme
                                                    .tertiaryContainer),
                                            icon: Icon(
                                              Icons.arrow_forward_rounded,
                                              color: theme.colorScheme.onInverseSurface,
                                            ),
                                            label: Text(
                                              "Nouveau trait",
                                              style: TextStyle(
                                                  color: theme.colorScheme.onInverseSurface),
                                            )))
                                  ],
                                )))
                              ],
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 4),
                          itemCount: controller.linesNumber(),
                          itemBuilder: (BuildContext context, int index) {
                            final line = controller.getCurrentIndex(index);

                            return SizedBox(
                                height: 100,
                                child: InkWell(
                                    onTap: () {
                                      if (!controller
                                          .reasonIsTooLong(line.reason)) return;

                                      Get.bottomSheet(
                                        lineBottomSheet(line, theme),
                                        backgroundColor:
                                            theme.colorScheme.onInverseSurface,
                                        enableDrag: true,
                                      );
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            side: BorderSide(
                                                color: theme.colorScheme
                                                    .tertiaryContainer,
                                                width: 0.4)),
                                        color:
                                            theme.colorScheme.onInverseSurface,
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                  WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle,
                                                      child: Icon(
                                                        Icons.check,
                                                        color: theme.colorScheme
                                                            .primaryContainer,
                                                        size: 16,
                                                      )),
                                                  TextSpan(
                                                      text: line.sender,
                                                      style: TextStyle(
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                          fontSize: 16)),
                                                  WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_right_alt_rounded,
                                                        size: 28,
                                                        color: theme.colorScheme
                                                            .onSurface,
                                                      )),
                                                  TextSpan(
                                                      text: line.recipient,
                                                      style: TextStyle(
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                          fontSize: 16))
                                                ])),
                                                Expanded(
                                                    child: Text(line.reason,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        DateFormat(
                                                                'dd/MM/y HH:mm:ss')
                                                            .format(
                                                                line.createdAt),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ])
                                              ]),
                                        ))));
                          },
                        ),
                      ))))
      ],
    ));
  }

  Widget lineBottomSheet(Line line, theme) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: Container(
              width: 40,
              height: 6,
              decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
            ))
      ]),
      Padding(
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
          child: Expanded(
              child: Text(
            line.reason,
            style: const TextStyle(fontSize: 12),
          )))
    ]);
  }
}
