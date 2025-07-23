import 'package:get/get.dart';

import 'clock_setting_logic.dart';

class ClockSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClockSettingLogic());
  }
}
