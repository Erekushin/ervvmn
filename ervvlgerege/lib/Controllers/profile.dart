import 'package:ervvlgerege/Models/userInfo/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helpers/logging.dart';
import '../Models/general.dart';
import '../Models/survey.dart';
import 'dart:convert';
import '../Helpers/load_json.dart';
import '../Models/userInfo/my_services.dart';
import '../global_constants.dart';

class ProC extends GetxController {
  late GeneralRes generalRes;
  final medlog = logger(ProC);

  var specialistSwitcher = false.obs;
  var isSpecialist = true.obs;
  //#region general information.........................
  var myName = TextEditingController();
  var myDiscription = TextEditingController();
  var myPhone = TextEditingController();
  var myMail = TextEditingController();
  var myPass = TextEditingController();
  var myRd = TextEditingController();

  Map<String, dynamic> generalInfoB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = userEntranceData.userInfo?.id ?? '';
    data['username'] =
        myName.text.isEmpty ? userEntranceData.userInfo?.username : myName.text;
    data['profile_picture'] = userEntranceData.userInfo?.profilePicture ?? '';
    data['user_info'] = myDiscription.text.isEmpty
        ? userEntranceData.userInfo?.userInfo
        : myDiscription.text;
    return data;
  }

  Future generalInfo() async {
    generalRes = GeneralRes();
    var data = await GlobalHelpers.apiReq
        .postdata(generalInfoB(), '${Addresses.mArea}auth/user/update/user');
    medlog.wtf(
        '----SAVE GENERAL INFO----Send body: ${generalInfoB()}............Returned Data: $data');
    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
    switch (generalRes.code) {
      case '200':
        Get.snackbar('Амжилттай хадгаллаа', "",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: const EdgeInsets.all(5));
        break;
      case '500':
        //TODO zurgaa butsaagaad ustgah
        break;
    }
  }
  //#endregion general information.........................

  //myServices
  var serviceName = TextEditingController();
  var serviceDiscription = TextEditingController();

  MyServiceB myServiceB = MyServiceB();
  Future getMyServices() async {
    String jsonString = await loadFromAsset("assets/file/my_services.json");
    generalRes = GeneralRes.fromJson(jsonDecode(jsonString));
    if (generalRes.code == "200") {
      myServiceB = MyServiceB.fromJson(generalRes.result);
    }
  }

  UserEntranceData userEntranceData = UserEntranceData();
  Survey survey = Survey();
  Future getSurvey() async {
    String jsonString =
        await loadFromAsset("assets/file/specialist_registration.json");
    generalRes = GeneralRes.fromJson(jsonDecode(jsonString));
    survey = Survey.fromJson(generalRes.result);
  }
}
