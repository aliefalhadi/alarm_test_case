import 'dart:math';

import 'package:alarm_test_case/domain/entities/clock_entity.dart';
import 'package:alarm_test_case/presentation/themes/themes.dart';
import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final ClockEntity clockEntity;

  ClockPainter({required this.clockEntity});
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY);
    double outerRadius = radius - 20;
    Offset center = Offset(centerX, centerY);

    for (var element in clockEntity.listOffsHour) {
      canvas.drawLine(element[0], element[1], S.paint.hourDashPaint);
    }

    for (var element in clockEntity.listOffsMinute) {
      canvas.drawLine(element[0], element[1], S.paint.minuteDashPaint);
    }

    Offset minStartOffset = Offset(
      centerX - outerRadius * .6 * cos(clockEntity.minute * 6 * pi / 180),
      centerX - outerRadius * .6 * sin(clockEntity.minute * 6 * pi / 180),
    );
    Offset minEndOffset = Offset(
      centerX + 20 * cos(clockEntity.minute * 6 * pi / 180),
      centerX + 20 * sin(clockEntity.minute * 6 * pi / 180),
    );

    Offset hourStartOffset = Offset(
      centerX -
          outerRadius *
              .4 *
              cos((clockEntity.hour + (clockEntity.minute / 60)) *
                  30 *
                  pi /
                  180),
      centerX -
          outerRadius *
              .4 *
              sin((clockEntity.hour + (clockEntity.minute / 60)) *
                  30 *
                  pi /
                  180),
    );
    Offset hourEndOffset = Offset(
      centerX +
          20 *
              cos((clockEntity.hour + (clockEntity.minute / 60)) *
                  30 *
                  pi /
                  180),
      centerX +
          20 *
              sin((clockEntity.hour + (clockEntity.minute / 60)) *
                  30 *
                  pi /
                  180),
    );

    if (clockEntity.isEdit) {
      if (clockEntity.isEditHour) {
        Offset editEndOffset = Offset(
            centerX - outerRadius * cos(clockEntity.hour * 30 * pi / 180),
            centerY - outerRadius * sin(clockEntity.hour * 30 * pi / 180));

        canvas.drawLine(center, editEndOffset, S.paint.secLinePaintHour);
      } else {
        Offset editEndOffset = Offset(
            centerX - outerRadius * cos(clockEntity.minute * 6 * pi / 180),
            centerY - outerRadius * sin(clockEntity.minute * 6 * pi / 180));

        canvas.drawLine(center, editEndOffset, S.paint.secLinePaintMinute);
      }
    } else {
      canvas.drawLine(minStartOffset, minEndOffset, S.paint.minPaint);
      canvas.drawLine(hourStartOffset, hourEndOffset, S.paint.hourPaint);
    }

    canvas.drawCircle(center, 4, S.paint.centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
