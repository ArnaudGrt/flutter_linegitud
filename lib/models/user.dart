import 'dart:convert';

class User {
  int id;
  String name;
  String password;
  String avatar;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      avatar: json['avatar']
    );
  }
}

class CleanUser {
  int? id;
  String name;
  String avatar;

  CleanUser({
    this.id,
    required this.name,
    required this.avatar,
  });
}

class RankingUser {
  String name;
  String avatar;
  int total;
  String totalText;

  RankingUser({
    required this.name,
    required this.avatar,
    required this.total,
    required this.totalText
  });
}

class UserList {
  List<User> userList;

  UserList({ required this.userList });

  factory UserList.fromJson(String json){
    final Map<String, dynamic> data = jsonDecode(json);

    var list = data['list'] as List;

    List<User> userList = list.map((i) {
      return User.fromJson(i);
    }).toList();

    return UserList(userList: userList);
  }

  List getCleanUsers(){
    return userList.map((u) {
      return CleanUser(name: u.name, avatar: u.avatar);
    }).toList();
  }
}