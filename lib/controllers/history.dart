import 'package:get/get.dart';

import 'package:linegitud/api/mocks/line.dart';
import 'package:linegitud/models/line.dart';

class HistoryController extends GetxController {
  Rx<LineList> lineList = Rx(LineList(lineList: []));

  @override
  void onInit(){
    initLineHistory();

    super.onInit();
  }

  bool linesHistoryEmpty(){
    return lineList.value.hasNoLines();
  }
  
  int linesNumber(){
    return lineList.value.linesLength();
  }

  Line getCurrentIndex(int index){
    return lineList.value.getFromIndex(index);
  }

  void initLineHistory() {
    final jsonData = mockLine(); // HARDCODED LINELIST FROM MOCK

    lineList.value = LineList.fromJson(jsonData);
  }

  Future<void> refreshLinesHistory(){
    initLineHistory();

    return Future.delayed(const Duration(seconds: 3));
  }
}