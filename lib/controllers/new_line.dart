import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/models/db.dart';

import 'package:linegitud/models/line.dart';
import 'package:linegitud/models/user.dart';

class NewLineController extends GetxController {
  final DataBaseController dbController = Get.find();

  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  
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

  Future createLine() async {
    toggleLoader(true);

    final lines = await fetchLines();
    // @Arnaud : if one day it is possible to delete a line, change lineCount with a MAX() SQL QUERY
    final linesCount = lines.linesLength();
    final nextId = linesCount + 1;
    final createdAt = DateFormat("y-MM-dd HH:mm:ss").format(DateTime.now());

    int res = await dbController.database.rawInsert(
    '''
      INSERT INTO lines(id, sender, recipient, reason, state, created_at)
        VALUES
        (?, ?, ?, ?, ?, ?)
    ''',
    [nextId, lineSender.value, lineRecipient.value, lineReason.value, 'validated', createdAt]);

    toggleLoader(false);

    if(res == nextId){
      return DbResultId(success: true, id: res);
    }

    return DbResult(success: false, error: "Tout ne s'est pas passé correctement... Il y eu un problème lors de l'ajout du trait...");
  }

  void toggleLoader(bool value){
    if(isLoading.value == value) return;

    isLoading.value = value;
    isLoading.refresh();
  }
}