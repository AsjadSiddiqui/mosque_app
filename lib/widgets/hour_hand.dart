import 'dart:math';
import 'package:flutter/material.dart';

class HourHand extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final int hours;
  final int minutes;
  final double deviceWidth;

  HourHand({
    this.strokeColor = Colors.black,
    this.strokeWidth = 3,
    this.paintingStyle = PaintingStyle.stroke,
    @required this.hours,
    @required this.minutes,
    @required this.deviceWidth,
  });

  void rotate(Canvas canvas, double cx, double cy, double angle) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    //checks if hour is greater than 12 before calculating rotation
    // canvas.translate(
    //     this.hours >= 12
    //         ? 2 * pi * ((this.hours - 12) / 12 + (this.minutes / 720))
    //         : 2 *
    //                 pi *
    //                 ((this.hours / 12) + (this.minutes / 720)) *
    //                 (deviceWidth - 64) /
    //                 2 *
    //                 0.5 +
    //             0.5,
    //     -(deviceWidth - 64) / 2 * 0.15);
    // canvas.translate(size.width / 2, size.width / 2);
    // canvas.rotate(this.hours >= 12
    //     ? 2 * pi * ((this.hours - 12) / 12 + (this.minutes / 720))
    //     : 2 * pi * ((this.hours / 12) + (this.minutes / 720)));
    rotate(
      canvas,
      size.width / 2,
      size.height / 2,
      hours >= 12
          ? 2 * pi * ((hours - 12) / 12 + (minutes / 720))
          : 2 * pi * ((hours / 12) + (minutes / 720)),
    );
    canvas.translate(0, -(deviceWidth - 64) / 2 * 0.15);
    canvas.drawShadow(
        getHourHandPath(size.width, size.height), Colors.black, 2, true);

    canvas.drawPath(getHourHandPath(size.width, size.height), paint);
  }

  Path getHourHandPath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x, y)
      ..lineTo(x, 15)
      ..moveTo(0, y)
      ..lineTo(0, 15)
      ..lineTo(x / 2, 0)
      ..lineTo(x, 15);
  }

  @override
  bool shouldRepaint(HourHand oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.minutes != minutes ||
        oldDelegate.hours != hours;
  }
}
