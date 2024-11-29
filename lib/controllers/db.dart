import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataBaseController extends GetxController {
  var database;
  final initLoading = true.obs;

  @override
  void onInit(){
    databaseFactory = databaseFactoryFfi;
    initDatabase();

    super.onInit();
  }

  initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();

    database = await openDatabase(
      join(directory.path, 'linegitud.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE users
          (
            id INTEGER PRIMARY KEY, 
            name VARCHAR, 
            password VARCHAR, 
            avatar VARCHAR
          )
          ''',
        );

        await db.execute(
          '''
          INSERT INTO users(id, name, password, avatar)
            VALUES
            (1, 'Arnaud', '111111', 'https://picsum.photos/200?random=1'),
            (2, 'Samuel', '222222', 'https://picsum.photos/200?random=2'),
            (3, 'Frédéric', '333333', 'https://picsum.photos/200?random=3'),
            (4, 'Claire', '444444', 'https://picsum.photos/200?random=4'),
            (5, 'Marion', '555555', 'https://picsum.photos/200?random=5'),
            (6, 'Maxime', '666666', 'https://picsum.photos/200?random=6')
          '''
        );

        await db.execute(
          '''
          CREATE TABLE lines
          (
            id INTEGER PRIMARY KEY, 
            reason TEXT, 
            sender VARCHAR, 
            recipient VARCHAR, 
            state VARCHAR, 
            created_at VARCHAR
          )
          '''
        );
      },
      version: 1,
    );

    initLoading.value = false;
  }
}