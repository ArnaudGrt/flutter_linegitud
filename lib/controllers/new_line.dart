import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linegitud/api/mocks/user.dart';
import 'package:linegitud/models/user.dart';

class NewLineController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<List> users = Rx([]);

  @override
  void onInit(){
    fetchUsers();

    super.onInit();
  }

   void fetchUsers(){
    final usersData = mockUser();
    final userList = UserList.fromJson(usersData);

    users.value = userList.getCleanUsers();
  }
}