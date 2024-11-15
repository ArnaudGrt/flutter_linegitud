import 'dart:convert';

class User {
  int id;
  String name;
  String password;
  String icon;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.icon
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      icon: json['icon']
    );
  }
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

  List namesOnly(){
    return userList.map((u) => u.name).toList();
  }
}