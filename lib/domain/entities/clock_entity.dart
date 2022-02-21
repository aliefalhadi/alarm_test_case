import 'dart:ui';

import 'package:equatable/equatable.dart';

class ClockEntity extends Equatable {
  final int hour;
  final int minute;
  final List<List<Offset>> listOffsHour;
  final List<List<Offset>> listOffsMinute;
  final List<Offset> listMaxOffsHour;
  final List<Offset> listMaxOffsMinute;
  final bool isAMClock;
  final bool isEdit;
  final bool isEditHour;
  final bool isEditMinute;
  final bool isAlarmActive;

  const ClockEntity(
      {required this.hour,
      required this.minute,
      required this.listOffsHour,
      required this.listOffsMinute,
      required this.listMaxOffsHour,
      required this.listMaxOffsMinute,
      required this.isEdit,
      required this.isAMClock,
      required this.isEditHour,
      required this.isEditMinute,
      required this.isAlarmActive});

  ClockEntity copyWith(
      {int? hour,
      int? minute,
      List<List<Offset>>? listOffsHour,
      List<List<Offset>>? listOffsMinute,
      List<Offset>? listMaxOffsHour,
      List<Offset>? listMaxOffsMinute,
      bool? isAMClock,
      bool? isEdit,
      bool? isEditHour,
      bool? isEditMinute,
      bool? isAlarmActive}) {
    return ClockEntity(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      listOffsHour: listOffsHour ?? this.listOffsHour,
      listOffsMinute: listOffsMinute ?? this.listOffsMinute,
      listMaxOffsHour: listMaxOffsHour ?? this.listMaxOffsHour,
      listMaxOffsMinute: listMaxOffsMinute ?? this.listMaxOffsMinute,
      isAMClock: isAMClock ?? this.isAMClock,
      isEdit: isEdit ?? this.isEdit,
      isEditHour: isEditHour ?? this.isEditHour,
      isEditMinute: isEditMinute ?? this.isEditMinute,
      isAlarmActive: isAlarmActive ?? this.isAlarmActive,
    );
  }

  @override
  List<Object> get props => [
        hour,
        minute,
        listOffsHour,
        listOffsMinute,
        listMaxOffsHour,
        listMaxOffsMinute,
        isAMClock,
        isEdit,
        isEditHour,
        isEditMinute,
        isAlarmActive
      ];
}
