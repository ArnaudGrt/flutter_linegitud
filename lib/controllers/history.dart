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

  // DATA FUNCTIONS
  // void fetchLinesHistory() {
  //   final jsonData = mockLine(); // HARDCODED LINELIST FROM MOCK

  //   lineList.value = LineList.fromJson(jsonData, ['validated']);
  // }

  Future<List<Line>> fetchLinesHistory() async {
    final linesQuery = await dbController.database.rawQuery("SELECT * FROM lines ORDER BY created_at");

    return linesQuery.map((line) {
      return Line(id: line.id, reason: line.reason, sender: line.sender, recipient: line.recipient, state: line.state, createdAt: DateTime.parse(line.created_at));
    });
  }

  // Future<void> getLinesHistory(bool withLoader) async {
  //   if(withLoader){
  //     toggleLoader(true);
  //   }

  //   Timer(Duration(seconds: durationValue), () {
  //     fetchLinesHistory();
  //     toggleLoader(false);
  //   });

  //   return Future.delayed(Duration(seconds: durationValue));
  // }

  Future<void> initLinesHistory() async {
    final linesList = await fetchLinesHistory();

    lineList.value = LineList(lineList: linesList);
  }

  // void initLinesHistory(){
  //   getLinesHistory(true);
  // }

  Future<void> refreshLinesHistory() async {
    toggleLoader(true);
    final linesList = await fetchLinesHistory();
    toggleLoader(false);

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