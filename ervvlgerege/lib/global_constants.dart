import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Helpers/api_request.dart';
import 'Helpers/chat_helper.dart';
import 'Helpers/image_helper.dart';
import 'Helpers/working_file.dart';

enum BioSupportState {
  unknown,
  supported,
  unsupported,
}

enum BottomNavbarKeys {
  home,
  profile,
  addPost,
  medicalHome,
  chat,
  hideNavBar,
  hideSideBar
}

class GlobalHelpers {
  static ApiReq apiReq = ApiReq();
  static ImageHelper imageHelper = ImageHelper();
  static WorkingFile workingWithFile = WorkingFile();
  static ChatHelper chatHelper = ChatHelper();
  static late StreamController<BottomNavbarKeys> bottomnavbarSwitcher;
  static String auth = '';
  static int myUserId = 0;
  static String deviceToken = '';

  static bool ifFingering = false;
  static String pass = '';
  static String name = '';
  GlobalHelpers.fromJson(Map<String, dynamic> json) {
    if (json['isFingering'] == null) {
      ifFingering = false;
    } else {
      if (json['isFingering'] == 'true') {
        ifFingering = true;
      } else if (json['isFingering'] == 'false') {
        ifFingering = false;
      } else {
        ifFingering = false;
      }
    }
    pass = json['pass'] ?? '';
    name = json['name'] ?? '';
  }
}

class Addresses {
  static const String mArea = "https://medtech-app.gerege.mn/";
  static const String mm =
      "localhost:8080/auth/public/register/foreign/surveytest";
}

class RouteUnits {
  //others
  static String search = "/search";

  //entrance
  static String login = "/login";
  static String register = "/signup";
  static String forgetpass = "/forgetpass";

  //Medical
  static String medicalhome = "/medicalhome";
  static String doctorPro = "/doctorPro";

  static String splashScreen = "/splashScreen";

  //profile
  static String profile = "/profile";
  static String generalInfo = "/generalInfo";
  static String healthInfo = "/healthInfo";
  static String wallet = "/wallet";
  static String taskCalendar = "/taskCalendars";

  static String specialistSetting = "/specialistSetting";
  static String specialistRegistration = "/specialistRegistration";
  static String myServices = "/myServices";
  static String myServiceInfo = "/myServiceInfo";

  //setting
  static String setting = "/setting";

  //chat
  static String chathome = "/chathome";
  static String conversation = "/conversation";
  static String videoCall = "/videoCall";
}

class Sizes {
  static double height = Get.height;
  static double width = Get.width;
  static double snackbarBottomMargin = height * .12;

  ///delgetsnii baruun zvvn talaasaa barih margin
  static double hmargin = Get.width * .05;
}

class Mcolors {
  static Color geregeBlue = const Color(0xFF1755F6);
  static Color medicalGreen = const Color(0xFF05A386);
  static Color deepGreen = const Color(0xFF159900);
  static Color deepPink = const Color(0xFFFF4484);
}

class SCargubody {
  int? initialPage;
  String? fromRoute;
}
