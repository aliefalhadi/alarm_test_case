import 'package:alarm_test_case/data/models/alarm_model.dart';
import 'package:alarm_test_case/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class AlarmRepository {
  Future<Either<AppError, bool>> createAlarm(Alarm params);
  Future<Either<AppError, Alarm?>> getAlarmActive();
  Future<Either<AppError, List<Alarm>>> getAllAlarm();
  Future<Either<AppError, bool>> updateAlarmActive();
  Future<Either<AppError, bool>> deleteAlarmActive();
}
