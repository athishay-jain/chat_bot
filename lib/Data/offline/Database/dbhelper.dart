import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Dbhelper {
  static const String table_name = "chat";
  static const String table_question = "question";
  static const String table_response = "response";
  static const String table_id = "id";

  Dbhelper._();

  static Dbhelper getInstances() => Dbhelper._();
  Database? db;

  Future<Database> getDb() async {
    if (db != null) {
      return db!;
    } else {
      db = await openDb();
      return db!;
    }
  }

  Future<Database> openDb() async {
    Directory appDire = await getApplicationDocumentsDirectory();
    String appDb = join(appDire.path, "zentra.db");
    return openDatabase(
      appDb,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "create table $table_name($table_id integer primary key autoincrement,$table_question text,$table_response text)",
        );
      },
    );
  }

  Future<bool> addResponse({
    required String question,
    required String response,
  }) async {
    Database db = await getDb();
    int rowsEffected = await db.insert(table_name, {
      table_question: question,
      table_response: response,
    });
    return rowsEffected > 0;
  }
  Future<List<Map<String, dynamic>>> getData()async{
    Database db = await getDb();
    List<Map<String,dynamic>>mData = await db.query(table_name);
    return mData;
  }
}
