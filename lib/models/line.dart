import 'dart:convert';

class Line {
  int id;
  String reason;
  String sender;
  String recipient;
  String state;
  DateTime createdAt;

  Line({
    required this.id,
    required this.reason,
    required this.sender,
    required this.recipient,
    required this.state,
    required this.createdAt
  });

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      id: json['id'],
      reason: json['reason'],
      sender: json['sender'],
      recipient: json ['recipient'],
      state: json['state'],
      createdAt: DateTime.parse(json['created_at'])
    );
  }
}

class LineList {
  List<Line> lineList;

  LineList({ required this.lineList });

  factory LineList.fromJson(String json, List<String> states){
    final Map<String, dynamic> data = jsonDecode(json);

    var list = data['list'] as List;
    // Filtered by states
    var filteredList = list.where((data) =>
      states.contains(data['state'])
    ).toList();

    // Sort by created_at (most recent first)
    filteredList.sort((a, b) => b['created_at'].compareTo(a['created_at']));

    List<Line> lineList = filteredList.map((i) => Line.fromJson(i)).toList();

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

  // Return lines count from a user name
  int linesCount(String name){
    final userLines = lineList.where((line) =>
      line.recipient == name
    );

    return userLines.length;
  }
}