import 'package:alarm_test_case/data/core/dabatase_helper.dart';
import 'package:alarm_test_case/data/core/notification_api.dart';
import 'package:alarm_test_case/data/data_sources/alarm_local_data_source.dart';
import 'package:alarm_test_case/data/repositories/alarm_repository_impl.dart';
import 'package:alarm_test_case/domain/repositories/alarm_repository.dart';
import 'package:alarm_test_case/domain/usecases/create_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/delete_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/get_active_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/get_all_alarm_case.dart';
import 'package:alarm_test_case/domain/usecases/update_alarm_case.dart';
import 'package:alarm_test_case/presentation/blocs/clock/clock_bloc.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future init() async {
  injectDataSource();
  injectRepository();
  injectBloc();
  injectUseCase();
}

void injectUseCase() {
  getItInstance.registerLazySingleton<GetAllAlarmCase>(
      () => GetAllAlarmCase(getItInstance()));
  getItInstance.registerLazySingleton<GetActiveAlarmCase>(
      () => GetActiveAlarmCase(getItInstance()));
  getItInstance.registerLazySingleton<CreateAlarmCase>(
      () => CreateAlarmCase(getItInstance()));
  getItInstance.registerLazySingleton<UpdateAlarmCase>(
      () => UpdateAlarmCase(getItInstance()));
  getItInstance.registerLazySingleton<DeleteAlarmCase>(
      () => DeleteAlarmCase(getItInstance()));
}

void injectBloc() {
  getItInstance.registerFactory<ClockBloc>(() => ClockBloc(getItInstance(),
      getItInstance(), getItInstance(), getItInstance(), getItInstance()));
}

void injectRepository() {
  getItInstance.registerLazySingleton<AlarmRepository>(
      () => AlarmRepositoryImpl(getItInstance(), getItInstance()));
}

void injectDataSource() {
  getItInstance.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  getItInstance.registerLazySingleton<NotificationApi>(() => NotificationApi());
  getItInstance.registerLazySingleton<AlarmLocalDataSource>(
      () => AlarmLocalDataSourceImpl(getItInstance()));
}
