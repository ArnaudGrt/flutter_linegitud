import 'dart:convert';

class User {
  double id;
  String name;
  String password;

  User({
    required this.id,
    required this.name,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password']
    );
  }
}

class UserList {
  List<User> userList;

  UserList({ required this.userList });

  factory UserList.fromJson(String json){
    final Map<String, dynamic> data = jsonDecode(json);

    var list = data['list'] as List;
    List<User> userList = list.map((i) => User.fromJson(i)).toList();

    return UserList(userList: userList);
  }
}