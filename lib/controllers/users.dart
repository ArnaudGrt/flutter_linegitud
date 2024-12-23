import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/models/db.dart';
import 'package:linegitud/models/user.dart';

class UsersController extends GetxController {
  final DataBaseController dbController = Get.find();

  // Search Form
  final searchFormKey = GlobalKey<FormState>();
  final userSearchValue = "".obs;
  // User Form
  final userFormKey = GlobalKey<FormState>();
  final userName = "".obs;
  final userAvatar = "".obs;

  Future searchUser() async {
    final formattedUserValue = userSearchValue.value.capitalizeFirst;

    final userQuery = await dbController.database.rawQuery(
        "SELECT id, name, avatar FROM users WHERE name = ? LIMIT 1", [formattedUserValue]);

    if (userQuery.length == 1) {
      return DbResultUser(
          success: true,
          user: CleanUser(id: userQuery.first['id'], name: userQuery.first['name'], avatar: userQuery.first['avatar']));
    }

    return DbResult(success: false);
  }

  Future deleteUser(String name) async {
    final userQuery = await dbController.database.rawDelete(
      "DELETE FROM users WHERE name = ?", [name]
    );

    if(userQuery == 1){
      return DbResult(success: true);
    }

    return DbResult(success: false, error: "La suppression ne s'est passée comme prévue...");
  }
}
