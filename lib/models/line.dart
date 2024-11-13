import 'dart:convert';

class Line {
  int id;
  String reason;
  String sender;
  String recipient;
  String state;

  Line({
    required this.id,
    required this.reason,
    required this.sender,
    required this.recipient,
    required this.state
  });

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      id: json['id'],
      reason: json['reason'],
      sender: json['sender'],
      recipient: json ['recipient'],
      state: json['state']
    );
  }
}

class LineList {
  List<Line> lineList;

  LineList({ required this.lineList });

  factory LineList.fromJson(String json){
    final Map<String, dynamic> data = jsonDecode(json);

    var list = data['list'] as List;
    List<Line> lineList = list.map((i) => Line.fromJson(i)).toList();

    return LineList(lineList: lineList);
  }

  // Return if a LineList is empty or not
  bool hasNoLines(){
    return lineList.isEmpty;
  }

  // Return length of LineList
  int linesLength(){
    return lineList.length;
  }

  // Return Line from index
  Line getFromIndex(int index){
    return lineList[index];
  }
}