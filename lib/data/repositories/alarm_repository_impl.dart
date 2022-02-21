import 'package:alarm_test_case/data/core/notification_api.dart';
import 'package:alarm_test_case/data/data_sources/alarm_local_data_source.dart';
import 'package:alarm_test_case/data/models/alarm_model.dart';
import 'package:alarm_test_case/domain/entities/app_error.dart';
import 'package:alarm_test_case/domain/repositories/alarm_repository.dart';
import 'package:dartz/dartz.dart';

class AlarmRepositoryImpl extends AlarmRepository {
  final AlarmLocalDataSource _alarmLocalDataSource;
  final NotificationApi _notificationApi;

  AlarmRepositoryImpl(this._alarmLocalDataSource, this._notificationApi);

  @override
  Future<Either<AppError, bool>> createAlarm(Alarm params) async {
    try {
      await _alarmLocalDataSource.createAlarm(params);
      _notificationApi.showScheduleNotification(
          title: "Alarm is comming",
          body: "this alarm is already",
          payload: "alarm",
          scheduledDate: params.alarmStart);
      return const Right(true);
    } on Exception {
      return const Left(AppError(AppErrorType.api, message: 'ada kesalahan'));
    }
  }

  @override
  Future<Either<AppError, Alarm?>> getAlarmActive() async {
    try {
      final alarm = await _alarmLocalDataSource.getActiveAlarm();

      return Right(alarm);
    } on Exception {
      return const Left(AppError(AppErrorType.api, message: 'ada kesalahan'));
    }
  }

  @override
  Future<Either<AppError, bool>> deleteAlarmActive() async {
    try {
      await _alarmLocalDataSource.deleteActiveAlarm();
      _notificationApi.cancelAll();
      return const Right(true);
    } on Exception {
      return const Left(AppError(AppErrorType.api, message: 'ada kesalahan'));
    }
  }

  @override
  Future<Either<AppError, bool>> updateAlarmActive() async {
    try {
      await _alarmLocalDataSource.updateAlarm();
      return const Right(true);
    } on Exception {
      return const Left(AppError(AppErrorType.api, message: 'ada kesalahan'));
    }
  }

  @override
  Future<Either<AppError, List<Alarm>>> getAllAlarm() async {
    try {
      final alarm = await _alarmLocalDataSource.getAllAlarm();

      return Right(alarm);
    } on Exception {
      return const Left(AppError(AppErrorType.api, message: 'ada kesalahan'));
    }
  }
}
