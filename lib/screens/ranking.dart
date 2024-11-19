import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:linegitud/controllers/ranking.dart';

class UserRanking extends StatelessWidget {
  UserRanking({super.key});

  final UserRankingController controller = Get.find();

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
            ))
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
                    return controller.refreshRankingList();
                  },
                  notificationPredicate: defaultScrollNotificationPredicate,
                  child: Obx(() => controller.ranking.value.isEmpty
                      ? CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(children: [
                                Expanded(
                                    child: Center(
                                        child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.medal,
                                      size: 120,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Aucun grand gagnant,",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        "le classement est vide...",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                )))
                              ]),
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 4,
                            ),
                            itemCount: controller.ranking.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              final user = controller.ranking.value[index];

                              return Text(user.totalText);
                            },
                          )))))
        ],
      ),
    );
  }
}
