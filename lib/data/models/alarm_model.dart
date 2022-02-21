const String tableNotes = 'alarm';

class AlarmrFields {
  static final List<String> values = [id, alarmStart, alarmEnd];

  static const String id = '_id';
  static const String alarmStart = 'alarm_start';
  static const String alarmEnd = 'alarm_end';
}

class Alarm {
  final int? id;
  final DateTime alarmStart;
  final DateTime? alarmEnd;

  const Alarm({this.id, required this.alarmStart, required this.alarmEnd});

  Alarm copy({int? id, DateTime? alarmStart, DateTime? alarmEnd}) => Alarm(
      id: id ?? this.id,
      alarmStart: alarmStart ?? this.alarmStart,
      alarmEnd: alarmEnd ?? this.alarmEnd);

  static Alarm fromJson(Map<String, Object?> json) => Alarm(
        id: json[AlarmrFields.id] as int?,
        alarmStart: DateTime.parse(json[AlarmrFields.alarmStart] as String),
        alarmEnd: json[AlarmrFields.alarmEnd] == ""
            ? null
            : DateTime.parse(json[AlarmrFields.alarmEnd] as String),
      );

  Map<String, Object?> toJson() => {
        AlarmrFields.id: id,
        AlarmrFields.alarmStart: alarmStart.toIso8601String(),
        AlarmrFields.alarmEnd:
            alarmEnd == null ? "" : alarmEnd!.toIso8601String(),
      };
}
