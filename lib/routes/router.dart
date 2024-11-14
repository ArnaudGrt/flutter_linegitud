import 'package:get/get.dart';

import 'package:linegitud/bindings/history.dart';
import 'package:linegitud/bindings/home.dart';
import 'package:linegitud/bindings/lines_list.dart';
import 'package:linegitud/bindings/new_line.dart';

import 'package:linegitud/screens/home.dart';
import 'package:linegitud/screens/lines_list.dart';
import 'package:linegitud/screens/new_line.dart';
import 'package:linegitud/screens/history.dart';
import 'package:linegitud/screens/settings.dart';

class AppRoutes {
  static const String history = "/history";
  static const String home = "/";
  static const String list = "/list";
  static const String newLine = "/new-line";
  static const String settings = "/settings";
  
  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const Home(),
      bindings: [
        HomeBindings()
      ]
    ),
    GetPage(
      name: list,
      page: () => const LinesList(),
      bindings: [
        LinesListBindings()
      ]
    ),
    GetPage(
      name: newLine,
      page: () => const NewLine(),
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
      page: () => const Settings(),
      transition: Transition.leftToRight,
    )
  ];
}