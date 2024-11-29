import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:linegitud/controllers/db.dart';

import 'package:linegitud/models/line.dart';
import 'package:linegitud/models/user.dart';

class NewLineController extends GetxController {
  final DataBaseController dbController = Get.find();

  final formKey = GlobalKey<FormState>();
  Rx<List> users = Rx([]);

  Rx lineSender = Rx(null);
  Rx lineRecipient = Rx(null);
  Rx<String> lineReason = Rx("");

  @override
  void onInit(){
    initUsers();

    super.onInit();
  }

  void initUsers() async {
    users.value = await fetchUsers();
  }

  Future <List<CleanUser>> fetchUsers() async {
    final usersQuery = await dbController.database.rawQuery("SELECT name, avatar FROM users");

    final usersArray = [
      for(final {
        'name': name as String,
        'avatar': avatar as String
      } in usersQuery)
        CleanUser(name: name, avatar: avatar)
    ];

    return usersArray.toList();
  }

  Future<LineList> fetchLines() async {
    final linesQuery = await dbController.database.query("lines");

    final linesArray = [
      for(final {
          'id': id as int,
          'sender': sender as String,
          'recipient': recipient as String,
          'reason': reason as String,
          'state': state as String,
          'created_at': createdAt as String
      } in linesQuery)
        Line(id: id, reason: reason, sender: sender, recipient: recipient, state: state, createdAt: DateTime.parse(createdAt))
    ];

    return LineList(lineList: linesArray);
  }

  void createLine() async {
    final lines = await fetchLines();
    final linesCount = lines.linesLength();
    final nextId = linesCount + 1;
    final createdAt = DateFormat("y/M/d H:m:s").format(DateTime.now());

    await dbController.database.rawInsert(
    '''
      INSERT INTO lines(id, sender, recipient, reason, state, created_at)
        VALUES
        (?, ?, ?, ?, ?, ?)
    ''',
    [nextId, lineSender.value, lineRecipient.value, lineReason.value, 'validated', createdAt]);
  }
}