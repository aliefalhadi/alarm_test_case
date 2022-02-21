import 'package:alarm_test_case/data/core/notification_api.dart';
import 'package:alarm_test_case/di/get_it.dart';
import 'package:alarm_test_case/presentation/blocs/clock/clock_bloc.dart';
import 'package:alarm_test_case/presentation/themes/themes.dart';
import 'package:alarm_test_case/presentation/views/components/analog_clock.dart';
import 'package:alarm_test_case/presentation/views/detail_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alarm extends StatefulWidget {
  static const String tag = '/home';

  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  late ClockBloc _clockBloc;

  @override
  void initState() {
    super.initState();
    _clockBloc = getItInstance<ClockBloc>();
    _clockBloc.add(InitClockEvent());

    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickNotification);
  void onClickNotification(String? payload) {
    Navigator.pushNamed(context, DetailAlarm.tag);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClockBloc>.value(
      value: _clockBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        bottomSheet: BlocBuilder<ClockBloc, ClockState>(
          bloc: _clockBloc,
          builder: (context, state) {
            if (state is ClockLoaded) {
              if (state.clockEntity.isEdit) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: const Text("SET"),
                    onPressed: () {
                      _clockBloc
                          .add(FinishEditInitClockEvent(state.clockEntity));
                    },
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
        body: BlocBuilder<ClockBloc, ClockState>(
          builder: (context, state) {
            if (state is ClockLoaded) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      "Alarm",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (!state.clockEntity.isAlarmActive) {
                              _clockBloc.add(
                                  EditHourInitClockEvent(state.clockEntity));
                            }
                          },
                          child: Text(
                            state.clockEntity.hour.toString().padLeft(2, '0'),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: state.clockEntity.isEdit &&
                                            state.clockEntity.isEditHour
                                        ? FontWeight.bold
                                        : null),
                          ),
                        ),
                        Text(
                          ":",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        InkWell(
                          onTap: () {
                            if (!state.clockEntity.isAlarmActive) {
                              _clockBloc.add(
                                  EditMinuteInitClockEvent(state.clockEntity));
                            }
                          },
                          child: Text(
                            state.clockEntity.minute.toString().padLeft(2, '0'),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(
                                    fontWeight: state.clockEntity.isEdit &&
                                            state.clockEntity.isEditMinute
                                        ? FontWeight.bold
                                        : null),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (!state.clockEntity.isAlarmActive) {
                                  _clockBloc.add(EditTypeClockInitClockEvent(
                                      clockEntity: state.clockEntity,
                                      isAM: true));
                                }
                              },
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "AM",
                                  style: state.clockEntity.isAMClock
                                      ? S.textStyles.typeClockActive
                                      : S.textStyles.typeClockInActive,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                if (!state.clockEntity.isAlarmActive) {
                                  _clockBloc.add(EditTypeClockInitClockEvent(
                                      clockEntity: state.clockEntity,
                                      isAM: false));
                                }
                              },
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "PM",
                                  style: state.clockEntity.isAMClock
                                      ? S.textStyles.typeClockInActive
                                      : S.textStyles.typeClockActive,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const AnalogClock(),
                    const SizedBox(height: 24),
                    _buildButtonSetAlarm(state, context)
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  SizedBox _buildButtonSetAlarm(ClockLoaded state, BuildContext context) {
    if (state.clockEntity.isEdit) {
      return const SizedBox();
    }
    return SizedBox(
        width: MediaQuery.of(context).size.width - 24,
        child: ElevatedButton(
            onPressed: () {
              _clockBloc.add(SetAlarmClockEvent(state.clockEntity));
            },
            style: ElevatedButton.styleFrom(
                primary: state.clockEntity.isAlarmActive
                    ? S.colors.centerCirclePaintColor
                    : S.colors.hourPaintColor,
                padding: const EdgeInsets.all(14)),
            child: Text(
              state.clockEntity.isAlarmActive
                  ? "TURN OFF ALARM"
                  : "TURN ON ALARM",
              style: const TextStyle(fontSize: 21),
            )));
  }
}
