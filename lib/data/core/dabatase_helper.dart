import 'dart:io';
import 'package:alarm_test_case/data/models/alarm_model.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_alarm.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _createDB);
    return ourDb;
  }

  FutureOr<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textNullType = 'TEXT NULL';

    await db.execute('''
    CREATE TABLE alarm ( 
      ${AlarmrFields.id} $idType, 
      ${AlarmrFields.alarmStart} $textType,
      ${AlarmrFields.alarmEnd} $textNullType
      )
    ''');
  }
}
