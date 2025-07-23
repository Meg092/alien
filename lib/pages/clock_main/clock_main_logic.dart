import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_clock/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockMainLogic extends GetxController {

  var backgroundColor = 4.obs;
  var clockStyle = 0.obs;
  
  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final randomColor = prefs.getBool('randomColor') ?? true;
    final randomClock = prefs.getBool('randomClock') ?? true;
    final random = Random();

    if (randomColor) {
      backgroundColor.value = random.nextInt(5);
      await prefs.setInt('randomColorIndex', backgroundColor.value);
    } else {
      backgroundColor.value = prefs.getInt('randomColorIndex') ?? 4;
    }
    if (randomClock) {
      clockStyle.value = random.nextInt(2);
      await prefs.setInt('randomClockIndex', clockStyle.value);
    } else {
      clockStyle.value = prefs.getInt('randomClockIndex') ?? 0;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
