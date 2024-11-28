import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataBaseController extends GetxController {
  var database;
  final initLoading = true.obs;

  @override
  void onInit(){
    print('init');
    
    databaseFactory = databaseFactoryFfi;
    initDatabase();

    super.onInit();
  }

  initDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'linegitud.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, VARCHAR name, VARCHAR password, VARCHAR avatar)',
        );

        await db.execute(
          'CREATE TABLE lines(id INTEGER PRIMARY KEY, VARCHAR reason, VARCHAR sender, VARCHAR recipient, VARCHAR state, DATETIME created_at)'
        );
      }
    );

    print(database);

    initLoading.value = false;
  }
}