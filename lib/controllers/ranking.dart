import 'dart:async';

import 'package:get/get.dart';
import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/models/line.dart';
import 'package:linegitud/models/user.dart';

class UserRankingController extends GetxController {
  final DataBaseController dbController = Get.find();

  Rx<List> ranking = Rx([]);
  final durationValue = 2;
  final isLoading = false.obs;

  @override
  void onInit(){
    initRanking();

    super.onInit();
  }
 
  Future<List<RankingUser>> fetchRanking() async {
    final users = await fetchUsers();
    final lines = await fetchLines();

    return users.map((user){
      final linesCount = lines.linesCount(user.name);

      return RankingUser(name: user.name, avatar: user.avatar, total: linesCount, totalText: linesCount.toString());
    }).toList()..sort((a, b) => b.total.compareTo(a.total));
  }

  Future<void> initRanking() async {
    toggleLoader(true);
    final rankingList = await fetchRanking();
    toggleLoader(false);

    ranking.value = rankingList;
  }

  Future<void> refreshRankingList() async {
    final rankingList = await fetchRanking();

    ranking.value = rankingList;
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

  void toggleLoader(bool value){
    if(isLoading.value == value) return;

    isLoading.value = value;
    isLoading.refresh();
  }
}