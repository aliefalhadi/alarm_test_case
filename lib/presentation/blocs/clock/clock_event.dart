part of 'clock_bloc.dart';

abstract class ClockEvent extends Equatable {
  const ClockEvent();
}

class InitClockEvent extends ClockEvent {
  @override
  List<Object?> get props => [];
}

class DetailClockEvent extends ClockEvent {
  @override
  List<Object?> get props => [];
}

class EditHourInitClockEvent extends ClockEvent {
  final ClockEntity clockEntity;

  const EditHourInitClockEvent(this.clockEntity);
  @override
  List<Object?> get props => [clockEntity];
}

class EditMinuteInitClockEvent extends ClockEvent {
  final ClockEntity clockEntity;

  const EditMinuteInitClockEvent(this.clockEntity);

  @override
  List<Object?> get props => [clockEntity];
}

class FinishEditInitClockEvent extends ClockEvent {
  final ClockEntity clockEntity;

  const FinishEditInitClockEvent(this.clockEntity);
  @override
  List<Object?> get props => [clockEntity];
}

class EditTypeClockInitClockEvent extends ClockEvent {
  final bool isAM;
  final ClockEntity clockEntity;

  const EditTypeClockInitClockEvent(
      {required this.clockEntity, required this.isAM});
  @override
  List<Object?> get props => [clockEntity, isAM];
}

class PanDragClockEvent extends ClockEvent {
  final ClockEntity clockEntity;
  final Offset localPosition;

  const PanDragClockEvent(
      {required this.clockEntity, required this.localPosition});
  @override
  List<Object?> get props => [clockEntity, localPosition];
}

class SetAlarmClockEvent extends ClockEvent {
  final ClockEntity clockEntity;

  const SetAlarmClockEvent(this.clockEntity);

  @override
  List<Object?> get props => [clockEntity];
}
