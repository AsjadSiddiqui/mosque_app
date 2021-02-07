import 'dart:math';
import 'package:flutter/material.dart';

class MinuteHand extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final int seconds;
  final int minutes;
  final double deviceWidth;

  MinuteHand({
    this.strokeColor = Colors.black,
    this.strokeWidth = 3,
    this.paintingStyle = PaintingStyle.stroke,
    @required this.seconds,
    @required this.minutes,
    @required this.deviceWidth,
  });

  void rotate(Canvas canvas, double cx, double cy, double angle) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    rotate(
      canvas,
      size.width / 2,
      size.height / 2,
      2 * pi * ((minutes + seconds / 60) / 60),
    );
    canvas.translate(0, -(deviceWidth - 64) / 2 * 0.3);

    canvas.drawShadow(
        getMinuteHandPath(size.width, size.height), Colors.black, 4, true);
    canvas.drawPath(getMinuteHandPath(size.width, size.height), paint);
  }

  Path getMinuteHandPath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x, y)
      ..lineTo(x, 15)
      ..moveTo(0, y)
      ..lineTo(0, 15)
      ..lineTo(x / 2, 0)
      ..lineTo(x, 15)
      ..close();
  }

  @override
  bool shouldRepaint(MinuteHand oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.minutes != minutes ||
        oldDelegate.seconds != seconds;
  }
}
