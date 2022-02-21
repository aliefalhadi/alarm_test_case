part of 'clock_bloc.dart';

abstract class ClockState extends Equatable {
  const ClockState();
}

class ClockInitial extends ClockState {
  @override
  List<Object> get props => [];
}

class ClockLoaded extends ClockState {
  final ClockEntity clockEntity;

  const ClockLoaded({
    required this.clockEntity,
  });

  ClockLoaded copyWith({
    ClockEntity? clockEntity,
  }) {
    return ClockLoaded(
      clockEntity: clockEntity ?? this.clockEntity,
    );
  }

  @override
  List<Object> get props => [clockEntity];
}

class DetailClockLoaded extends ClockState {
  final List<Map<String, dynamic>> dataChart;

  const DetailClockLoaded(this.dataChart);
  @override
  List<Object?> get props => [dataChart];
}
