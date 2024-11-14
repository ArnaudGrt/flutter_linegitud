import 'dart:async';

import 'package:get/get.dart';

import 'package:linegitud/api/mocks/line.dart';
import 'package:linegitud/models/line.dart';

class HistoryController extends GetxController {
  Rx<LineList> lineList = Rx(LineList(lineList: []));
  final durationValue = 2;
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
  void fetchLinesHistory() {
    final jsonData = mockLine(); // HARDCODED LINELIST FROM MOCK

    lineList.value = LineList.fromJson(jsonData, ['validated']);
  }

  Future<void> getLinesHistory(withLoader) async {
    if(withLoader){
      toggleLoader(true);
    }

    Timer(Duration(seconds: durationValue), () {
      fetchLinesHistory();
      toggleLoader(false);
    });

    return Future.delayed(Duration(seconds: durationValue));
  }

  void initLinesHistory(){
    getLinesHistory(true);
  }

  void refreshLinesHistory() async {
    await getLinesHistory(false);
  }

  void toggleLoader(bool value){
    if(isLoading.value == value) return;

    isLoading.value = value;
    isLoading.refresh();
  }
}