import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:linegitud/controllers/ranking.dart';

class UserRanking extends StatelessWidget {
  UserRanking({super.key});

  final UserRankingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => showContent());
  }

  Widget showContent() {
    // var theme = Theme.of(Get.context!);

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

    return Container();
  }
}
