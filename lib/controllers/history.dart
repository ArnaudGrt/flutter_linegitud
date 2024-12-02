import 'dart:async';

import 'package:get/get.dart';

import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/models/line.dart';

class HistoryController extends GetxController {
  final DataBaseController dbController = Get.find();

  Rx<LineList> lineList = Rx(LineList(lineList: []));
  final durationValue = 2;
  final reasonLength = 75;
  final isLoading = false.obs;

  @override
  // INIT
  void onInit(){
    initLinesHistory();

    super.onInit();
  }

  // LINES LIST FUNCTIONS
  bool linesHistoryEmpty(){
    return lineList.value.hasNoLines();
  }
  
  int linesNumber(){
    return lineList.value.linesLength();
  }

  Line getCurrentIndex(int index){
    return lineList.value.getFromIndex(index);
  }

  Future<List<Line>> fetchLines() async {
    final linesQuery = await dbController.database.rawQuery("SELECT * FROM lines ORDER BY created_at DESC");

    return [
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
  }

  Future<void> initLinesHistory() async {
    toggleLoader(true);
    final linesList = await fetchLines();
    toggleLoader(false);
    
    lineList.value = LineList(lineList: linesList);
  }

  Future<void> refreshLinesHistory() async {
    final linesList = await fetchLines();

    lineList.value = LineList(lineList: linesList);
  }

  void toggleLoader(bool value){
    if(isLoading.value == value) return;

    isLoading.value = value;
    isLoading.refresh();
  }

  bool reasonIsTooLong(String reason){
    return reason.length >= reasonLength;
  }
}