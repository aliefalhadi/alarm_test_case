import 'package:alarm_test_case/data/models/alarm_model.dart';
import 'package:alarm_test_case/domain/entities/app_error.dart';
import 'package:alarm_test_case/domain/repositories/alarm_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAlarmCase {
  final AlarmRepository alarmRepository;

  CreateAlarmCase(this.alarmRepository);

  Future<Either<AppError, bool>> call(Alarm params) async =>
      alarmRepository.createAlarm(params);
}
