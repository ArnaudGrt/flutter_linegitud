import 'package:flutter/material.dart';
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
      return const Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
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
                color: Colors.white,
                backgroundColor: theme.colorScheme.primary,
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
                                      Icons.auto_awesome_outlined,
                                      size: 120,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                          "Aucun trait n'a encore été ajouté :(",
                                          style: TextStyle(
                                              color: Colors.black,
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
                                                backgroundColor:
                                                    theme.colorScheme.primary),
                                            icon: const Icon(
                                              Icons.arrow_forward_rounded,
                                              color: Colors.white,
                                            ),
                                            label: const Text(
                                              "Nouveau trait",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                        backgroundColor: Colors.white,
                                        enableDrag: true,
                                      );
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            side: BorderSide(
                                                color:
                                                    theme.colorScheme.primary,
                                                width: 0.4)),
                                        color: Colors.white,
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                  const WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle,
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                        size: 16,
                                                      )),
                                                  TextSpan(
                                                      text: line.sender,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16)),
                                                  const WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_right_alt_rounded,
                                                        size: 28,
                                                      )),
                                                  TextSpan(
                                                      text: line.recipient,
                                                      style: const TextStyle(
                                                          color: Colors.black,
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
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
            ))
      ]),
      Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
          child: Expanded(
              child: Text(
            line.reason,
            style: const TextStyle(fontSize: 12),
          )))
    ]);
  }
}
