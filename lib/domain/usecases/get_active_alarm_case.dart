import 'package:alarm_test_case/data/models/alarm_model.dart';
import 'package:alarm_test_case/domain/entities/app_error.dart';
import 'package:alarm_test_case/domain/repositories/alarm_repository.dart';
import 'package:dartz/dartz.dart';

class GetActiveAlarmCase {
  final AlarmRepository alarmRepository;

  GetActiveAlarmCase(this.alarmRepository);

  Future<Either<AppError, Alarm?>> call() async =>
      alarmRepository.getAlarmActive();
}
