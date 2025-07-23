import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:picker_clock/pages/clock_design/clock_design_binding.dart';
import 'package:picker_clock/pages/clock_design/clock_design_view.dart';
import 'package:picker_clock/pages/clock_main/clock_main_binding.dart';
import 'package:picker_clock/pages/clock_main/clock_main_view.dart';
import 'package:picker_clock/pages/clock_main/count_clock.dart';
import 'package:picker_clock/pages/clock_setting/clock_setting_binding.dart';
import 'package:picker_clock/pages/clock_setting/clock_setting_view.dart';
import 'package:picker_clock/pages/net_refresh/net_refresh_binding.dart';
import 'package:picker_clock/pages/net_refresh/net_refresh_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.black;

List<Color> colorList = const [
  Color(0xff00ff6c),
  Color(0xffff9d00),
  Colors.white,
  Color(0xff363636),
  Colors.red
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final randomColor = prefs.getBool('randomColor');
  if (randomColor == null) {
   await prefs.setBool('randomColor', true);
   await prefs.setBool('randomClock', true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Alien,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Alien = [
  GetPage(name: '/', page: () => const ClockDesignView(), binding: ClockDesignBinding()),
  GetPage(name: '/clock_main', page: () => const ClockMainPage(), binding: ClockMainBinding()),
  GetPage(name: '/net_refresh', page: () => NetRefreshView(), binding: NetRefreshBinding()),
  GetPage(name: '/clock_count', page: () => CountClock()),
  GetPage(name: '/clock_setting', page: () => ClockSettingPage(), binding: ClockSettingBinding()),
];