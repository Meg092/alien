import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

class FirstClock extends StatefulWidget {
  const FirstClock({Key? key}) : super(key: key);

  @override
  State<FirstClock> createState() => _FirstClockState();
}

class _FirstClockState extends State<FirstClock> {
  Timer? _timer;

  var hourStr = '00'.obs;
  var minuteStr = '00'.obs;
  DateTime _currentTime = DateTime.now();

  void startTimer() {
    getDate();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getDate();
    });
  }

  void getDate() {
    final now = DateTime.now();
    hourStr.value = DateFormat('HH').format(now);
    minuteStr.value = DateFormat('mm').format(now);
    setState(() => _currentTime = DateTime.now());
  }

  double _calculateHourAngle() {
    return (_currentTime.hour % 12) * 30 + _currentTime.minute * 0.5;
  }

  double _calculateMinuteAngle() {
    return _currentTime.minute * 6 + _currentTime.second * 0.1;
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Image.asset(
        'assets/icon0.webp',
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      ),
      HandWidget(
        imagePath: 'assets/icon2.png',
        angle: _calculateMinuteAngle(),
        child: Obx(() {
          return Text(
            minuteStr.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          );
        }),
      ),
      HandWidget(
        imagePath: 'assets/icon1.png',
        angle: _calculateHourAngle(),
        child: Obx(() {
          return Text(
            hourStr.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ).marginOnly(bottom: 90);
        }),
      ),
    ].toStack(alignment: Alignment.center);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}

class HandWidget extends StatelessWidget {
  final String imagePath;
  final double angle;
  final Widget child;

  const HandWidget({
    super.key,
    required this.imagePath,
    required this.angle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * (pi / 180),
      child: Center(
        child: <Widget>[
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          child,
        ].toStack(alignment: Alignment.topCenter),
      ),
    );
  }
}
