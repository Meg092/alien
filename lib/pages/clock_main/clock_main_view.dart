import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:picker_clock/main.dart';
import 'package:picker_clock/pages/clock_main/first_clock.dart';
import 'package:picker_clock/pages/clock_main/rolling_clock.dart';
import 'package:picker_clock/pages/clock_main/second_clock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'clock_main_logic.dart';

class ClockMainPage extends StatefulWidget {
  const ClockMainPage({Key? key}) : super(key: key);

  @override
  State<ClockMainPage> createState() => _ClockMainPageState();
}

class _ClockMainPageState extends State<ClockMainPage>
    with SingleTickerProviderStateMixin {
  final ClockMainLogic controller = Get.find<ClockMainLogic>();

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _isAnimating = false;
  bool _isVisible = true;

  void qigegjqbjkj() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/net_refresh');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    qigegjqbjkj();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.41, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isAnimating = false);
      }
    });
    super.initState();
  }

  Widget _independentWidget() {
    if (controller.clockStyle.value == 0) {
      return const FirstClock();
    }
    if (controller.clockStyle.value == 1) {
      return const SecondClock();
    }
    return const SecondPickerScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration:
              BoxDecoration(color: colorList[controller.backgroundColor.value]),
          child: <Widget>[
            const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            _independentWidget(),
            SlideTransition(
              position: _offsetAnimation,
              child: <Widget>[
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                <Widget>[
                  Container(
                    width: 16,
                    height: 87,
                    child: <Widget>[
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 16,
                        color: Colors.white,
                      )
                    ].toRow(),
                  )
                      .decorated(
                          color: Colors.black,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6)))
                      .gestures(onTap: () {
                    if (!_isAnimating) {
                      setState(() => _isAnimating = true);
                      if (_isVisible) {
                        _isVisible = false;
                        _animationController.forward();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() => _isAnimating = false);
                        });
                      } else {
                        _isVisible = true;
                        _animationController.reverse();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() => _isAnimating = false);
                        });
                      }
                    }
                  }),
                  Container(
                    width: 350,
                    height: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: <Widget>[
                        const Text(
                          'Select background color',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                          child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1, mainAxisSpacing: 15),
                              itemCount: colorList.length,
                              itemBuilder: (_, index) {
                                return Obx(() {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border:
                                            controller.backgroundColor.value ==
                                                    index
                                                ? Border.all(
                                                    color: Colors.white,
                                                    width: 4)
                                                : null,
                                        color: colorList[index],
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ).gestures(onTap: () async {
                                    controller.backgroundColor.value = index;
                                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setInt('randomColorIndex', index);
                                  });
                                });
                              }),
                        ).marginSymmetric(vertical: 10),
                        const Text(
                          'Select clock style',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        <Widget>[
                          Transform.scale(
                            scale: 0.85,
                            child: const FirstClock().gestures(onTap: () async {
                              controller.clockStyle.value = 0;
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setInt('randomClockIndex', 0);
                            }),
                          ),
                          Transform.scale(
                            scale: 0.85,
                            child: const SecondClock().gestures(onTap: () async {
                              controller.clockStyle.value = 1;
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setInt('randomClockIndex', 1);
                            }),
                          ),
                          Transform.scale(
                            scale: 0.85,
                            child:
                                const SecondPickerScreen().gestures(onTap: () async {
                              controller.clockStyle.value = 2;
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setInt('randomClockIndex', 2);
                            }),
                          ),
                        ].toColumn(
                            crossAxisAlignment: CrossAxisAlignment.start),
                      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                    ),
                  ).decorated(
                      color: Colors.black.withOpacity(0.74),
                      gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.15),
                            Colors.black
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight))
                ].toRow(mainAxisAlignment: MainAxisAlignment.end),
              ].toStack(alignment: Alignment.centerRight),
            ),
            Positioned(
                top: 20,
                left: 20,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: <Widget>[
                    const Icon(
                      Icons.settings,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Program Settings',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )
                  ].toRow(),
                )
                    .decorated(
                        color: Colors.black.withOpacity(0.23),
                        borderRadius: BorderRadius.circular(25))
                    .gestures(onTap: () {
                  if (_isVisible) {
                    return;
                  }
                  Get.toNamed('/clock_setting')?.then((_) {
                    controller.getData();
                  });
                }))
          ].toStack(alignment: Alignment.center),
        );
      }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
