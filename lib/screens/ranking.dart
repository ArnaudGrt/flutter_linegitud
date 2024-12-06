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
      return Scaffold(
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.tertiaryContainer,
              ),
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
                  color: theme.colorScheme.onInverseSurface,
                  backgroundColor: theme.colorScheme.tertiary,
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
                                      color:
                                          theme.colorScheme.tertiaryContainer,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Aucun grand gagnant,",
                                        style: TextStyle(
                                            color: theme.colorScheme.onSurface,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        "le classement est vide...",
                                        style: TextStyle(
                                            color: theme.colorScheme.onSurface,
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
                      : Stack(children: [
                          podiumHeader(controller.ranking.value, theme),
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
                                itemCount: controller.ranking.value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final user = controller.ranking.value[index];

                                  rankingColor(int index) {
                                    if (index == 0) {
                                      return Colors.yellow[700];
                                    } else if (index == 1) {
                                      return Colors.grey[400];
                                    } else if (index == 2) {
                                      return Colors.brown[700];
                                    }

                                    return theme.colorScheme.onInverseSurface;
                                  }

                                  rankingTextColor(int index) {
                                    if ([0, 1, 2].contains(index)) {
                                      return const Color(0xFFfafcf1);
                                    }

                                    return theme.colorScheme.onSurface;
                                  }

                                  return Container(
                                      decoration: BoxDecoration(
                                          color: rankingColor(index),
                                          border: Border.all(
                                              color: [0, 1, 2].contains(index)
                                                  ? Colors.transparent
                                                  : theme.colorScheme
                                                      .tertiaryContainer,
                                              width: 0.4),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(24)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: theme.colorScheme.shadow,
                                              blurRadius: 20.0,
                                              spreadRadius: -20.0,
                                              offset: const Offset(0.0, 25.0),
                                            )
                                          ]),
                                      height: 48,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, right: 20),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    theme.colorScheme.surface,
                                                radius: 20,
                                                backgroundImage:
                                                    NetworkImage(user.avatar),
                                              ),
                                              Text(
                                                user.name,
                                                style: TextStyle(
                                                    color:
                                                        rankingTextColor(index),
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                user.total.toString(),
                                                style: TextStyle(
                                                    color:
                                                        rankingTextColor(index),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              )
                                            ]),
                                      ));
                                }),
                          ),
                        ]))))
        ],
      ),
    );
  }

  Widget podiumHeader(List ranking, theme) {
    return Container(
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
              ]),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(64, 64),
              bottomRight: Radius.elliptical(64, 64)),
        ),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: podiumElement(
                        2, Colors.grey[400], ranking[1].avatar, theme),
                  ),
                  podiumElement(
                      1, Colors.yellow[700], ranking[0].avatar, theme),
                  Transform.scale(
                      scale: 0.65,
                      child: podiumElement(
                          3, Colors.brown[700], ranking[2].avatar, theme))
                ])));
  }

  Widget podiumElement(int rank, color, String image, theme) {
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
                    backgroundColor: theme.colorScheme.surface,
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
                  style: const TextStyle(color: Color(0xFFfafcf1)),
                )),
          ),
        ],
      ),
    );
  }
}
