import 'package:alarm_test_case/domain/entities/clock_entity.dart';

class ConvertHandlers {
  ConvertHandlers();

  DateTime convertTimeToSave(ClockEntity clockEntity) {
    DateTime now = DateTime.now();

    int hour = clockEntity.hour;
    int minute = clockEntity.minute;
    if (!clockEntity.isAMClock) {
      hour += 12;
      if (hour == 24) {
        hour = 0;
      }
    }

    String dateAlarm =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00.000";

    DateTime dateAlarmParse = DateTime.parse(dateAlarm);

    if (now.isAfter(dateAlarmParse)) {
      dateAlarmParse = dateAlarmParse.add(const Duration(days: 1));
    }

    return dateAlarmParse;
  }
}
