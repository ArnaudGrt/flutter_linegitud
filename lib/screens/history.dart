import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:linegitud/controllers/history.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryController controller = Get.find();

    var theme = Theme.of(context);

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
                    ? const CustomScrollView(
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
                                    Icon(Icons.phonelink_setup_outlined),
                                    Text("History empty")
                                  ],
                                )))
                              ],
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: controller.linesNumber(),
                        itemBuilder: (BuildContext context, int index) {
                          final line = controller.getCurrentIndex(index);

                          return ListTile(title: Text(line.reason));
                        },
                      ))))
      ],
    ));
  }
}
