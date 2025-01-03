import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/models/db.dart';
import 'package:linegitud/models/user.dart';
import 'package:linegitud/utils/options.dart';
import 'package:sqflite/sqflite.dart';

class UsersController extends GetxController {
  final DataBaseController dbController = Get.find();

  // Search Form
  final searchFormKey = GlobalKey<FormState>();
  final userSearchValue = "".obs;

  Rx<Options<bool>> searchResultValue = Rx(Options<bool>());
  Rx<CleanUser> searchResultUser = Rx(CleanUser(name: "", avatar: ""));
  // User Form
  final userFormKey = GlobalKey<FormState>();
  final userName = "".obs;
  final userAvatar = "".obs;
  
  Rx<Options<DbResult>> newUserResult = Rx(Options<DbResult>());

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

  Future createUser() async {
    final formattedUserName = userName.value.capitalizeFirst ?? "";
    if(formattedUserName == "") return DbResult(success: false, error: "Le nom de l'utilisateur ne peut pas être vide...");

    DbResult userAlreadyExist = await checkUser(formattedUserName);

    if(userAlreadyExist.success){
      final currentIndexQuery = await fetchCurrentIndex();
      int currentIndex = Sqflite.firstIntValue(currentIndexQuery) ?? 0;
      int nextId = currentIndex + 1;

      String avatarUrl = userAvatar.value;
      if(!userAvatar.value.startsWith("http")){
        avatarUrl = "https://www.logitud.fr/wp-inside/themes/logitud.fr/assets/images/icons/favicon.png";
      }

      int res = await dbController.database.rawInsert(
        '''
          INSERT INTO users(id, name, avatar)
            VALUES
            (?, ?, ?)
        ''',
        [nextId, formattedUserName, avatarUrl]);
      
      if(res == nextId){
        return DbResultId(success: true, id: res);
      }

      return DbResult(success: false, error: "Tout ne s'est pas passé correctement... Il y eu un problème lors de l'ajout de l'utilisateur...");
    }

    return DbResult(success: false, error: "L'utilisateur $formattedUserName existe déjà");
  }

  Future<DbResult> checkUser(String value) async {
    final checkQuery = await dbController.database.rawQuery(
      "SELECT id FROM users WHERE name = ? LIMIT 1", [value]);

    if(checkQuery.length == 0){
      return DbResult(success: true);
    }

    return DbResult(success: false);
  }

  Future fetchCurrentIndex() async {
    final userCount = await dbController.database.rawQuery(
      "SELECT MAX(id) FROM users");

    return userCount;
  }
}
