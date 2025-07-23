import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'clock_setting_logic.dart';

class ClockSettingPage extends GetView<ClockSettingLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['Random color', 'Random dial', 'Version'];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 2
            ? const Text("1.0.0(1)").paddingOnly(right: 8)
            : Obx(() {
                return Switch(
                    value: index == 0
                        ? controller.randomColor.value
                        : controller.randomClock.value,
                    activeTrackColor: Colors.green,
                    onChanged: (v) async {
                      index == 0
                          ? controller.randomColor.value = v
                          : controller.randomClock.value = v;
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool(
                          index == 0 ? 'randomColor' : 'randomClock', v);
                    });
              })
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                _item(0, context),
                _item(1, context),
                _item(2, context)
              ].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ).marginAll(15)),
      ).decorated(
        color: const Color(0xff910001),
      ),
    );
  }
}
