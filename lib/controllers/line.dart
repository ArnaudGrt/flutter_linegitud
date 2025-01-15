import 'package:get/get.dart';
import 'package:linegitud/controllers/db.dart';
import 'package:linegitud/models/db.dart';
import 'package:sqflite/sqflite.dart';

class LineController extends GetxController {
  final DataBaseController dbController = Get.find();

  Future<int> fromUser(String name) async {
    final query = await dbController.database.rawQuery(
      "SELECT MAX(id) FROM lines WHERE recipient = ?", [name]
    );

    return Sqflite.firstIntValue(query) ?? 0;
  }

  Future deleteFromUser(String name) async {
    final userLines = await fromUser(name);
    final query = await dbController.database.rawDelete(
      "DELETE FROM lines WHERE recipient = ?", [name]
    );

    if(query == 0 || (userLines != 0 && userLines == query)){
      return DbResult(success: true);
    }

    return DbResult(success: false, error: "Toutes les lignes de cet utilisateur n'ont pas été supprimées...");
  }
}