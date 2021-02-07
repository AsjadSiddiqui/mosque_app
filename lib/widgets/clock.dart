import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/hour_hand.dart';
import '../widgets/minute_hand.dart';
import '../widgets/second_hand.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({
    Key key,
  }) : super(key: key);

  @override
  AnalogClockState createState() => AnalogClockState();
}

class AnalogClockState extends State<AnalogClock> {
  DateTime currTime;
  Timer _timer;

  void setTime(Timer timer) {
    if (mounted) {
      setState(() {
        currTime = DateTime.now();
      });
    } else {
      print('Not Mounted !');
    }
  }

  @override
  void initState() {
    super.initState();
    currTime = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 40), setTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const Color dotColors = Color(0xFF858E97);
    currTime = DateTime.now();
    const Color textColor = Color(0xFF778089);

    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Container>[
                          Container(
                            width: 0.0635 * width,
                            height: 0.0635 * width,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: dotColors,
                            ),
                          ),
                          Container(
                            width: 0.0635 * width,
                            height: 0.0635 * width,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: dotColors,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Container>[
                          Container(
                            width: 0.0635 * width,
                            height: 0.0635 * width,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: dotColors,
                            ),
                          ),
                          Container(
                            width: 0.0635 * width,
                            height: 0.0635 * width,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: dotColors,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Small Dots:
                    Center(
                      child: Transform.rotate(
                        angle: (90 / 3) * (pi / 180),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Container>[
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Transform.rotate(
                        angle: (90 / 3 * 2) * (pi / 180),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Container>[
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Transform.rotate(
                        angle: (90 / 3 + 90) * (pi / 180),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Container>[
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Transform.rotate(
                        angle: (90 / 3 * 2 + 90) * (pi / 180),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Container>[
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                            Container(
                              width: 0.039 * width,
                              height: 0.039 * width,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColors,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Clock Hands:
                    Center(
                      // margin: EdgeInsets.only(bottom: (width - 64) / 2) * 0.35,
                      child: CustomPaint(
                        painter: HourHand(
                          paintingStyle: PaintingStyle.fill,
                          strokeColor: dotColors,
                          minutes: currTime.minute,
                          hours: currTime.hour,
                          deviceWidth: width,
                        ),
                        child: SizedBox(
                          height: ((width - 64) / 2) * 0.7,
                          width: 0.052 * width,
                        ),
                      ),
                    ),
                    Center(
                      child: CustomPaint(
                        painter: MinuteHand(
                          paintingStyle: PaintingStyle.fill,
                          strokeColor: dotColors,
                          minutes: currTime.minute,
                          seconds: currTime.second,
                          deviceWidth: width,
                        ),
                        child: SizedBox(
                          height: ((width - 64) / 2) * 1,
                          width: 0.035 * width,
                        ),
                      ),
                    ),
                    Center(
                      child: CustomPaint(
                        painter: SecondHand(
                          paintingStyle: PaintingStyle.fill,
                          strokeColor: const Color(0xFFC90000),
                          seconds: currTime.second,
                          deviceWidth: width,
                          milliseconds: currTime.millisecond,
                        ),
                        child: SizedBox(
                          height: ((width - 64) / 2) * 1.1,
                          width: 8,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 0.052 * width,
                        height: 0.052 * width,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateFormat('h').format(currTime),
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            Opacity(
              opacity: ((1000 - currTime.millisecond) / 1000),
              child: const Text(
                ':',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            Text(
              DateFormat('mm').format(currTime),
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
