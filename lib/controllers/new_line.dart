import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:linegitud/api/mocks/line.dart';
import 'package:linegitud/api/mocks/user.dart';

import 'package:linegitud/models/line.dart';
import 'package:linegitud/models/user.dart';

class NewLineController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<List> users = Rx([]);

  Rx lineSender = Rx(null);
  Rx lineRecipient = Rx(null);
  Rx<String> lineReason = Rx("");

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

  LineList fetchLines(){
    final jsonData = mockLine();
    return LineList.fromJson(jsonData, ['validated']);
  }

  void createLine(){
    final lines = fetchLines();
    final linesCount = lines.linesLength();

    Line(id: linesCount + 1, reason: lineReason.value, sender: lineSender.value, recipient: lineRecipient.value, state: "validated", createdAt: DateTime.now());
  }
}