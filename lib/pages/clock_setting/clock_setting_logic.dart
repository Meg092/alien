import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockSettingLogic extends GetxController {

  var randomColor = true.obs;
  var randomClock = true.obs;

  aboutClockUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 73,
        height: 73,
      ),
      children: [
        const Text(
            """We can customize different styles of watch faces for you"""),
      ],
      context: context,
    );
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    randomColor.value = prefs.getBool('randomColor') ?? true;
    randomClock.value = prefs.getBool('randomClock') ?? true;
    super.onInit();
  }

}
