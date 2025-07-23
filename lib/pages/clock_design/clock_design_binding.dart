import 'package:get/get.dart';

import 'clock_design_logic.dart';

class ClockDesignBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ClockDesignLogic(),
      permanent: true,
    );
  }
}
