import 'package:get/get.dart';

import 'net_refresh_logic.dart';

class NetRefreshBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetRefreshLogic());
  }
}
