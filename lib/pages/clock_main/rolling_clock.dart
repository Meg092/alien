import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

class SecondPickerScreen extends StatefulWidget {
  const SecondPickerScreen({super.key});

  @override
  State<SecondPickerScreen> createState() => _SecondPickerScreenState();
}

class _SecondPickerScreenState extends State<SecondPickerScreen> {
  late FixedExtentScrollController _controller;
  late Timer _timer;
  int _currentSecond = DateTime
      .now()
      .second;
  var hourMinutesStr = '00:00'.obs;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: _currentSecond);
    final currentNow = DateTime.now();
    hourMinutesStr.value = DateFormat('HH:mm').format(currentNow);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      hourMinutesStr.value = DateFormat('HH:mm').format(now);
      if (now.second != _currentSecond) {
        if (mounted) {
          setState(() {
            _currentSecond = now.second;
            _controller.animateToItem(
              _currentSecond,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309,
      height: 115,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: <Widget>[
        Obx(() {
          return Text(
            hourMinutesStr.value,
            style: const TextStyle(fontSize: 59, fontWeight: FontWeight.bold),
          ).marginOnly(left: 20);
        }),
        Container(
          width: 60,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListWheelScrollView.useDelegate(
            controller: _controller,
            itemExtent: 30,
            perspective: 0.01,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {},
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 60,
              builder: (context, index) {
                final isSelected = index == _currentSecond;
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey[700],
                    ),
                  ),
                );
              },
            ),
          ),
        ).marginOnly(right: 15),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).decorated(
      image: const DecorationImage(
          image: AssetImage('assets/icon4.webp'), fit: BoxFit.fill),
    );
  }
}
