import 'dart:math';

import 'package:alarm_test_case/common/utils/convert_handler.dart';
import 'package:alarm_test_case/data/models/alarm_model.dart';
import 'package:alarm_test_case/domain/entities/chart_alarm_entity.dart';
import 'package:alarm_test_case/domain/entities/clock_entity.dart';
import 'package:alarm_test_case/domain/usecases/create_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/delete_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/get_active_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/get_all_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/update_alarm_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'clock_event.dart';
part 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  final GetActiveAlarmCase getActiveAlarmCase;
  final CreateAlarmCase createAlarmCase;
  final DeleteAlarmCase deleteAlarmCase;
  final UpdateAlarmCase updateAlarmCase;
  final GetAllAlarmCase getAllAlarmCase;
  ClockBloc(this.getActiveAlarmCase, this.createAlarmCase, this.deleteAlarmCase,
      this.updateAlarmCase, this.getAllAlarmCase)
      : super(ClockInitial()) {
    on<ClockEvent>((event, emit) {});

    on<InitClockEvent>((event, emit) async {
      /// 300 is width container clock
      double centerX = 300 / 2;
      double centerY = 300 / 2;
      double radius = min(centerX, centerY);
      double outerRadius = radius - 20;
      double innerRadius = radius - 30;

      List<List<Offset>> listOffsetHour = [];
      List<List<Offset>> listOffsetMinute = [];
      List<Offset> listMaxOffsetHour = [];
      List<Offset> listMaxOffsetMinute = [];

      /// for generate offset for dash hour
      for (int i = 0; i < 360; i += 30) {
        double x1 = centerX - outerRadius * cos(i * pi / 180);
        double y1 = centerY - outerRadius * sin(i * pi / 180);

        double x2 = centerX - innerRadius * cos(i * pi / 180);
        double y2 = centerY - innerRadius * sin(i * pi / 180);

        double minX = max(x1, x2);
        double minY = max(y1, y2);
        int index = listMaxOffsetHour
            .indexWhere((element) => element == Offset(minX, minY));
        if (index < 0) {
          listMaxOffsetHour.add(Offset(minX, minY));
        }
        listOffsetHour.add([
          Offset(x1, y1),
          Offset(x2, y2),
        ]);
      }

      /// for generate offset for dash minute
      for (int i = 0; i < 360; i += 6) {
        double x1 = centerX - outerRadius * 0.95 * cos(i * pi / 180);
        double y1 = centerY - outerRadius * 0.95 * sin(i * pi / 180);

        double x2 = centerX - innerRadius * cos(i * pi / 180);
        double y2 = centerY - innerRadius * sin(i * pi / 180);

        double minX = max(x1, x2);
        double minY = max(y1, y2);
        int index = listMaxOffsetMinute
            .indexWhere((element) => element == Offset(minX, minY));
        if (index < 0) {
          listMaxOffsetMinute.add(Offset(minX, minY));
        }

        listOffsetHour.add([
          Offset(x1, y1),
          Offset(x2, y2),
        ]);
      }

      final eitherRes = await getActiveAlarmCase();

      eitherRes.fold((l) {
        debugPrint(l.appErrorType.toString());
      }, (r) {
        int hour = 0;
        bool isAMClock = true;

        if (r != null) {
          if (r.alarmStart.hour > 12) {
            hour = r.alarmStart.hour - 12;
            if (hour == 12) {
              hour = 0;
            }
            isAMClock = false;
          }
        }
        emit(ClockLoaded(
            clockEntity: ClockEntity(
                hour: r == null ? 2 : hour,
                minute: r == null ? 20 : r.alarmStart.minute,
                listOffsHour: listOffsetHour,
                listOffsMinute: listOffsetMinute,
                listMaxOffsHour: listMaxOffsetHour,
                listMaxOffsMinute: listMaxOffsetMinute,
                isAMClock: isAMClock,
                isEdit: false,
                isEditHour: false,
                isEditMinute: false,
                isAlarmActive: r == null ? false : true)));
      });
    });

    on<EditHourInitClockEvent>((event, emit) {
      emit(ClockLoaded(
          clockEntity: event.clockEntity
              .copyWith(isEdit: true, isEditHour: true, isEditMinute: false)));
    });

    on<EditMinuteInitClockEvent>((event, emit) {
      emit(ClockLoaded(
          clockEntity: event.clockEntity
              .copyWith(isEdit: true, isEditMinute: true, isEditHour: false)));
    });

    on<FinishEditInitClockEvent>((event, emit) {
      emit(ClockLoaded(
          clockEntity: event.clockEntity.copyWith(
              isEdit: false, isEditHour: false, isEditMinute: false)));
    });

    on<EditTypeClockInitClockEvent>((event, emit) {
      emit(ClockLoaded(
          clockEntity: event.clockEntity.copyWith(isAMClock: event.isAM)));
    });

    on<PanDragClockEvent>((event, emit) {
      if (event.clockEntity.isEditHour) {
        int indexLocation = getDistance(
            data: event.localPosition,
            listMaxOffsetHour: event.clockEntity.listMaxOffsHour)!;
        emit(ClockLoaded(
            clockEntity: event.clockEntity
                .copyWith(hour: indexLocation == 0 ? 12 : indexLocation)));
      } else {
        int indexLocation = getDistanceOffsetMinute(
            data: event.localPosition,
            listMaxOffsetMinute: event.clockEntity.listMaxOffsMinute)!;
        emit(ClockLoaded(
            clockEntity: event.clockEntity.copyWith(minute: indexLocation)));
      }
    });

    on<SetAlarmClockEvent>((event, emit) async {
      bool isAlarmActive = !event.clockEntity.isAlarmActive;
      Fluttertoast.showToast(
          msg: isAlarmActive ? "Alarm turn on" : "Alarm turn off");

      if (isAlarmActive) {
        DateTime date = ConvertHandlers().convertTimeToSave(event.clockEntity);

        final eitherRes =
            await createAlarmCase(Alarm(alarmStart: date, alarmEnd: null));

        eitherRes.fold((l) {
          debugPrint(l.appErrorType.toString());
        }, (r) {});
      } else {
        final eitherRes = await deleteAlarmCase();

        eitherRes.fold((l) {
          debugPrint(l.appErrorType.toString());
        }, (r) {});
      }

      emit(ClockLoaded(
          clockEntity:
              event.clockEntity.copyWith(isAlarmActive: isAlarmActive)));
    });

    on<DetailClockEvent>((event, emit) async {
      /// update date end alarm with datetime when click notification
      /// get all data alarm to show chart
      final eitherRes = await updateAlarmCase();
      eitherRes.fold((l) {
        debugPrint(l.appErrorType.toString());
      }, (r) {});
      final eitherRes2 = await getAllAlarmCase();
      eitherRes2.fold((l) {
        debugPrint(l.appErrorType.toString());
      }, (r) {
        /// convert data to data list chart
        List<Map<String, dynamic>> dataChart = [];
        for (var data in r) {
          dataChart.add({
            'domain': data.alarmStart.toString(),
            'measure': data.alarmEnd!.difference(data.alarmStart).inSeconds
          });
        }
        emit(DetailClockLoaded(dataChart));
      });
    });
  }

  int? getDistance(
      {required Offset data, required List<Offset> listMaxOffsetHour}) {
    /// get disctance position drag pan near from list position hour
    /// return index list
    int? index;
    double distance = 0;
    for (var dataList in listMaxOffsetHour) {
      double dist = 0;
      if (data > dataList) {
        dist = (data - dataList).distance;
      } else {
        dist = (dataList - data).distance;
      }

      if (index == null) {
        index = listMaxOffsetHour.indexWhere((element) => element == dataList);
        distance = dist;
      } else {
        if (dist < distance) {
          index =
              listMaxOffsetHour.indexWhere((element) => element == dataList);
          distance = dist;
        }
      }
    }
    return index;
  }

  int? getDistanceOffsetMinute(
      {required Offset data, required List<Offset> listMaxOffsetMinute}) {
    /// get disctance position drag pan near from list position minute
    /// return index list
    int? index;
    double distance = 0;
    for (var dataList in listMaxOffsetMinute) {
      double dist = 0;
      if (data > dataList) {
        dist = (data - dataList).distance;
      } else {
        dist = (dataList - data).distance;
      }

      if (index == null) {
        index =
            listMaxOffsetMinute.indexWhere((element) => element == dataList);
        distance = dist;
      } else {
        if (dist < distance) {
          index =
              listMaxOffsetMinute.indexWhere((element) => element == dataList);
          distance = dist;
        }
      }
    }
    return index;
  }
}
