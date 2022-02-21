import 'package:flutter/material.dart';

class S {
  static final colors = _Colors();
  static final textStyles = _TextStyles();
  static final fontWeight = _FontWeight();
  static final customWidget = _CustomWidget();
  static final paint = _Paint();
}

class _Colors {
  Color kPrimaryColor = const Color(0xFF041E41);
  Color kBlackColor = Colors.black;
  Color kWhiteColor = const Color(0xffFFFFFF);
  Color kGreyColor = const Color(0xff9698A9);
  Color kGreenColor = const Color(0xff0EC3AE);
  Color kRedColor = const Color(0xffEB70A5);
  Color kBackgroundColor = const Color(0xffFAFAFA);
  Color kInactiveColor = const Color(0xffDBD7EC);

  Color centerCirclePaintColor = const Color(0xFFE81466);
  Color minuteClockPaintColor = const Color(0xFFBEC5D5);
  Color hourPaintColor = const Color(0xFF222E63);
}

class _TextStyles {
  TextStyle typeClockActive =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle typeClockInActive =
      const TextStyle(fontSize: 18, color: Colors.grey);
}

class _FontWeight {
  FontWeight light = FontWeight.w300;
  FontWeight regular = FontWeight.w400;
  FontWeight medium = FontWeight.w500;
  FontWeight semiBold = FontWeight.w600;
  FontWeight bold = FontWeight.w700;
  FontWeight extraBold = FontWeight.w800;
  FontWeight black = FontWeight.w900;
}

class _CustomWidget {
  Widget hSpace(double space) {
    return SizedBox(
      width: space,
    );
  }

  Widget vSpace(double space) {
    return SizedBox(
      height: space,
    );
  }
}

class _Paint {
  Paint hourDashPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;

  Paint minuteDashPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  Paint minPaint = Paint()
    ..color = S.colors.minuteClockPaintColor
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;

  Paint hourPaint = Paint()
    ..color = S.colors.hourPaintColor
    ..strokeWidth = 6
    ..strokeCap = StrokeCap.round;

  Paint secLinePaintMinute = Paint()
    ..color = S.colors.minuteClockPaintColor
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;

  Paint secLinePaintHour = Paint()
    ..color = S.colors.hourPaintColor
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;

  Paint centerCirclePaint = Paint()..color = S.colors.centerCirclePaintColor;
}
