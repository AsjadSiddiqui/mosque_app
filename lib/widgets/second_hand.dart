import 'dart:math';
import 'package:flutter/material.dart';

class SecondHand extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final int seconds;
  final int milliseconds;
  final double deviceWidth;

  SecondHand({
    this.strokeColor = Colors.black,
    this.strokeWidth = 3,
    this.paintingStyle = PaintingStyle.stroke,
    @required this.seconds,
    @required this.milliseconds,
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

    rotate(
      canvas,
      size.width / 2,
      size.height / 2,
      2 * pi * (seconds + milliseconds / 1000) / 60,
    );
    canvas.translate(0, -(deviceWidth - 64) / 2 * 0.33);

    canvas.drawShadow(
        getSecondHandPath(size.width, size.height), Colors.black, 2, true);
    canvas.drawPath(getSecondHandPath(size.width, size.height), paint);
  }

  Path getSecondHandPath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x, y)
      ..lineTo((x / 2) + 0, 0)
      ..moveTo(0, y)
      ..lineTo((x / 2) - 0, 0)
      // ..lineTo(x / 2, 0)
      // ..lineTo(x, 15)
      ..close();
  }

  @override
  bool shouldRepaint(SecondHand oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.seconds != seconds ||
        oldDelegate.milliseconds != milliseconds;
  }
}
