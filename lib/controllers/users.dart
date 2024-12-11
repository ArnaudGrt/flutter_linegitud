import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/models/db.dart';
import 'package:linegitud/models/user.dart';

class UsersController extends GetxController {
  final DataBaseController dbController = Get.find();

  final userSearchValue = "".obs;
  final userName = "".obs;
  final userAvatar = "".obs;

  final searchFormKey = GlobalKey<FormState>();
  final userFormKey = GlobalKey<FormState>();

  Future<DbResult> searchUser() async {
    final formattedUserValue = userSearchValue.value.capitalizeFirst;

    final userQuery = await dbController.database.rawQuery(
        "SELECT id, name, avatar FROM users WHERE name = ? LIMIT 1", [formattedUserValue]);

    if (userQuery.length == 1) {
      return DbResult(
          success: true,
          user: CleanUser(id: userQuery.first['id'], name: userQuery.first['name'], avatar: userQuery.first['avatar']));
    }

    return DbResult(success: false);
  }
}
