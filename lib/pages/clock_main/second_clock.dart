import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

class SecondClock extends StatelessWidget {
  const SecondClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/icon3.webp')),
      ),
      child: const AnalogClock(
        dialColor: null,
        markingColor: null,
        hourNumberColor: Color(0xffa3a3a3),
        hourHandColor: Color(0xffa3a3a3),
        minuteHandColor: Color(0xffa3a3a3),
        secondHandColor: Color(0xffa3a3a3),
      ),
    );
  }
}
