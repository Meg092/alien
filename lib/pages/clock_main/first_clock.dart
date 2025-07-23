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
      Image.asset(
        'assets/icon2.webp',
        width: 240,
        height: 240,
        fit: BoxFit.cover,
      ),
      Image.asset(
        'assets/icon1.webp',
        width: 117,
        height: 117,
        fit: BoxFit.cover,
      ),
      Obx(() {
        return Text(
          hourStr.value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
        ).marginOnly(bottom: 90);
      }),
      Obx(() {
        return Transform(
          transform: Matrix4.identity()..rotateZ(pi / 2),
          alignment: Alignment.center,
          child: Text(
            minuteStr.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w500),
          ).marginOnly(bottom: 190),
        );
      })
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
