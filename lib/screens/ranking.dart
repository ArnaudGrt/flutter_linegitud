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
                      : SingleChildScrollView(
                          child: Column(
                          children: [
                            Stack(
                              children: [
                                podiumHeader(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 160, left: 32, right: 32, bottom: 8),
                                  child: ListView.separated(
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                                height: 4,
                                              ),
                                      itemCount:
                                          controller.ranking.value.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final user =
                                            controller.ranking.value[index];

                                        return SizedBox(
                                          height: 125,
                                          child: Text(user.name),
                                        );
                                      }),
                                ),
                              ],
                            )
                          ],
                        )))))
        ],
      ),
    );
  }

  Widget podiumHeader() {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(64, 64),
                bottomRight: Radius.elliptical(64, 64))),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: podiumElement(2, Colors.grey[400]),
                  ),
                  podiumElement(1, Colors.yellow[700]),
                  Transform.scale(
                      scale: 0.65, child: podiumElement(3, Colors.brown[700]))
                ])));
  }

  Widget podiumElement(int rank, color) {
    return SizedBox(
      height: 150,
      width: 110,
      child: Stack(
        children: [
          Positioned(
              top: 25,
              child: CircleAvatar(
                backgroundColor: color,
                radius: 55,
                child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://static.fundacion-affinity.org/cdn/farfuture/PVbbIC-0M9y4fPbbCsdvAD8bcjjtbFc0NSP3lRwlWcE/mtime:1643275542/sites/default/files/los-10-sonidos-principales-del-perro.jpg")),
              )),
          Positioned(
            left: 42,
            bottom: 6,
            child: CircleAvatar(
                backgroundColor: color,
                radius: 12,
                child: Text(
                  rank.toString(),
                  style: const TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
