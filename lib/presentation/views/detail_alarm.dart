import 'package:alarm_test_case/di/get_it.dart';
import 'package:alarm_test_case/presentation/blocs/clock/clock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailAlarm extends StatefulWidget {
  static const String tag = '/alarm/detail';

  const DetailAlarm({Key? key}) : super(key: key);

  @override
  _DetailAlarmState createState() => _DetailAlarmState();
}

class _DetailAlarmState extends State<DetailAlarm> {
  late ClockBloc clockBloc;

  @override
  void initState() {
    super.initState();
    clockBloc = getItInstance<ClockBloc>();
    clockBloc.add(DetailClockEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClockBloc>.value(
      value: clockBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Alarm"),
        ),
        body: BlocBuilder<ClockBloc, ClockState>(
          bloc: clockBloc,
          builder: (context, state) {
            if (state is DetailClockLoaded) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartBar(
                    data: [
                      {
                        'id': 'Bar',
                        'data': state.dataChart,
                      },
                    ],
                    xAxisTitle: 'Sale',
                    measureMin: 0,
                    measureMax: 7,
                    minimumPaddingBetweenLabel: 1,
                    domainLabelPaddingToAxisLine: 16,
                    axisLineTick: 2,
                    axisLinePointTick: 2,
                    axisLinePointWidth: 10,
                    axisLineColor: Colors.green,
                    measureLabelPaddingToAxisLine: 16,
                    verticalDirection: false,
                    barColor: (barData, index, id) => barData['measure'] >= 4
                        ? Colors.green.shade300
                        : Colors.green.shade700,
                    barValue: (barData, index) => '${barData['measure']}s',
                    showBarValue: true,
                    barValuePosition: BarValuePosition.outside,
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
