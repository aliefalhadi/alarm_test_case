import 'package:alarm_test_case/domain/entities/app_error.dart';
import 'package:alarm_test_case/domain/repositories/alarm_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAlarmCase {
  final AlarmRepository alarmRepository;

  DeleteAlarmCase(this.alarmRepository);

  Future<Either<AppError, bool>> call() async =>
      alarmRepository.deleteAlarmActive();
}
