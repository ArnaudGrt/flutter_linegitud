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
                                podiumHeader(controller.ranking.value),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 164, left: 32, right: 32, bottom: 8),
                                  child: ListView.separated(
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                                height: 12,
                                              ),
                                      itemCount:
                                          controller.ranking.value.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final user =
                                            controller.ranking.value[index];

                                        rankingColor(int index) {
                                          if (index == 0) {
                                            return Colors.yellow[700];
                                          } else if (index == 1) {
                                            return Colors.grey[400];
                                          } else if (index == 2) {
                                            return Colors.brown[700];
                                          }

                                          return Colors.white;
                                        }

                                        rankingTextColor(int index) {
                                          if ([0, 1, 2].contains(index)) {
                                            return Colors.white;
                                          }

                                          return Colors.black;
                                        }

                                        return Container(
                                            decoration: BoxDecoration(
                                                color: rankingColor(index),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(24)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(.5),
                                                      spreadRadius: 3,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3))
                                                ]),
                                            height: 48,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 20),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: theme
                                                          .colorScheme.primary,
                                                      radius: 20,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              user.avatar),
                                                    ),
                                                    Text(
                                                      user.name,
                                                      style: TextStyle(
                                                          color:
                                                              rankingTextColor(
                                                                  index),
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      user.total.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              rankingTextColor(
                                                                  index),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18),
                                                    )
                                                  ]),
                                            ));
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

  Widget podiumHeader(List ranking) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(64, 64),
                bottomRight: Radius.elliptical(64, 64)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child:
                        podiumElement(2, Colors.grey[400], ranking[1].avatar),
                  ),
                  podiumElement(1, Colors.yellow[700], ranking[0].avatar),
                  Transform.scale(
                      scale: 0.65,
                      child: podiumElement(
                          3, Colors.brown[700], ranking[2].avatar))
                ])));
  }

  Widget podiumElement(int rank, color, String image) {
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
                child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 50,
                    backgroundImage: NetworkImage(image)),
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
