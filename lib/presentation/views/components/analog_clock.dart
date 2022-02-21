import 'dart:math';
import 'package:alarm_test_case/presentation/blocs/clock/clock_bloc.dart';
import 'package:alarm_test_case/presentation/views/components/clock_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalogClock extends StatelessWidget {
  const AnalogClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClockBloc clockBloc = BlocProvider.of<ClockBloc>(context);
    return BlocBuilder<ClockBloc, ClockState>(
      bloc: clockBloc,
      builder: (context, state) {
        if (state is ClockLoaded) {
          return SizedBox(
            width: 300,
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffcadbeb),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffe3f0f8), Color(0xffeef5fd)]),
                  ),
                ),
                Transform.rotate(
                  angle: pi / 2,
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    child: GestureDetector(
                      onPanUpdate: (d) {
                        clockBloc.add(PanDragClockEvent(
                            clockEntity: state.clockEntity,
                            localPosition: d.localPosition));
                      },
                      onPanStart: (d) {
                        clockBloc.add(PanDragClockEvent(
                            clockEntity: state.clockEntity,
                            localPosition: d.localPosition));
                      },
                      child: CustomPaint(
                        painter: ClockPainter(clockEntity: state.clockEntity),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
