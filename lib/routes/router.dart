import 'package:get/get.dart';

import 'package:linegitud/bindings/history.dart';
import 'package:linegitud/bindings/home.dart';
import 'package:linegitud/bindings/ranking.dart';
import 'package:linegitud/bindings/new_line.dart';
import 'package:linegitud/bindings/settings.dart';
import 'package:linegitud/bindings/users.dart';

import 'package:linegitud/screens/home.dart';
import 'package:linegitud/screens/ranking.dart';
import 'package:linegitud/screens/new_line.dart';
import 'package:linegitud/screens/history.dart';
import 'package:linegitud/screens/settings.dart';
import 'package:linegitud/screens/users.dart';

class AppRoutes {
  static const String history = "/history";
  static const String home = "/";
  static const String ranking = "/ranking";
  static const String newLine = "/new-line";
  static const String settings = "/settings";
  static const String users = "/users";
  
  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const Home(),
      bindings: [
        HomeBindings()
      ]
    ),
    GetPage(
      name: ranking,
      page: () => UserRanking(),
      bindings: [
        UserRankingBindings()
      ]
    ),
    GetPage(
      name: newLine,
      page: () => NewLine(),
      bindings: [
        NewLineBindings()
      ]
    ),
    GetPage(
      name: history,
      page: () => History(),
      bindings: [
        HistoryBindings()
      ]
    ),
    GetPage(
      name: settings,
      page: () => Settings(),
      transition: Transition.leftToRight,
      bindings: [
        SettingsBindings()
      ]
    ),
    GetPage(
      name: users,
      page: () => Users(),
      bindings: [
        UsersBindings()
      ]
    )
  ];
}