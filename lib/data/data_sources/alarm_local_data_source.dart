import 'package:alarm_test_case/data/core/dabatase_helper.dart';
import 'package:alarm_test_case/data/models/alarm_model.dart';

abstract class AlarmLocalDataSource {
  Future<bool> createAlarm(Alarm data);
  Future<List<Alarm>> getAllAlarm();
  Future<Alarm?> getActiveAlarm();
  Future<bool> updateAlarm();
  Future<bool> deleteActiveAlarm();
}

class AlarmLocalDataSourceImpl extends AlarmLocalDataSource {
  final DatabaseHelper _databaseHelper;

  AlarmLocalDataSourceImpl(this._databaseHelper);
  @override
  Future<bool> createAlarm(Alarm data) async {
    var dbClient = await _databaseHelper.db;

    await dbClient!.insert("alarm", data.toJson());
    return true;
  }

  @override
  Future<Alarm?> getActiveAlarm() async {
    var dbClient = await _databaseHelper.db;

    final maps = await dbClient!.query(
      'alarm',
      columns: AlarmrFields.values,
      where: '${AlarmrFields.alarmEnd} = ?',
      whereArgs: [""],
    );

    if (maps.isNotEmpty) {
      return Alarm.fromJson(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteActiveAlarm() async {
    var dbClient = await _databaseHelper.db;
    await dbClient!.delete(
      "alarm",
      where: '${AlarmrFields.alarmEnd} = ?',
      whereArgs: [""],
    );
    return true;
  }

  @override
  Future<bool> updateAlarm() async {
    var dbClient = await _databaseHelper.db;
    final maps = await dbClient!.query(
      'alarm',
      columns: AlarmrFields.values,
      where: '${AlarmrFields.alarmEnd} = ?',
      whereArgs: [""],
    );

    if (maps.isNotEmpty) {
      Alarm data = Alarm.fromJson(maps.first);
      dbClient.update(
        'alarm',
        data.copy(alarmEnd: DateTime.now()).toJson(),
        where: '${AlarmrFields.alarmEnd} = ?',
        whereArgs: [""],
      );
    }
    return true;
  }

  @override
  Future<List<Alarm>> getAllAlarm() async {
    var dbClient = await _databaseHelper.db;

    final result = await dbClient!.query('alarm');

    return result.map((json) => Alarm.fromJson(json)).toList();
  }
}
