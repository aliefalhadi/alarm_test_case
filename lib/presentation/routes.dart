import 'package:alarm_test_case/presentation/views/detail_alarm.dart';
import 'package:alarm_test_case/presentation/views/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Alarm.tag:
        return MaterialPageRoute(builder: (_) => const Alarm());
      case DetailAlarm.tag:
        return MaterialPageRoute(builder: (_) => const DetailAlarm());
      default:
        return null;
    }
  }
}
