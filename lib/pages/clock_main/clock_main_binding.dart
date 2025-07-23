import 'package:get/get.dart';

import 'clock_main_logic.dart';

class ClockMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClockMainLogic());
  }
}
