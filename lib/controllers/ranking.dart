import 'dart:async';

import 'package:get/get.dart';

import 'package:linegitud/api/mocks/line.dart';
import 'package:linegitud/api/mocks/user.dart';

import 'package:linegitud/models/line.dart';
import 'package:linegitud/models/user.dart';

class UserRankingController extends GetxController {
  Rx<List> ranking = Rx([]);
  final durationValue = 2;
  final isLoading = false.obs;

  @override
  void onInit(){
    initRankingList();

    super.onInit();
  }

  List<dynamic> fetchUsers(){
    final usersData = mockUser();
    final usersList = UserList.fromJson(usersData);

    return usersList.namesOnly();
  }

  LineList fetchLines(){
    final linesData = mockLine();

    return LineList.fromJson(linesData, ['validated']);
  }

  List computeUsersLines(){
    final users = fetchUsers();
    final lines = fetchLines();
    List res = [];

    for (final userName in users){
      final linesCount = lines.linesCount(userName);

      res.add({ userName: linesCount });
    }

    return res;
  }

  Future<void> getRankingList(bool withLoader){
    if(withLoader){
      toggleLoader(true);
    }

    Timer(Duration(seconds: durationValue), () {
      computeUsersLines();
      toggleLoader(false);
    });

    return Future.delayed(Duration(seconds: durationValue));
  }

  void initRankingList(){
    getRankingList(true);
  }

  void refreshRankingList(){
    getRankingList(false);
  }

  void toggleLoader(bool value){
    if(isLoading.value == value) return;

    isLoading.value = value;
    isLoading.refresh();
  }
}