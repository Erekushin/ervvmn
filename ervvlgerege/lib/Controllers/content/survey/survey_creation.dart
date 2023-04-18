import 'dart:convert';

import 'package:ervvlgerege/global_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../Helpers/logging.dart';
import '../../../Models/content/content_creation.type.dart';
import '../../../Models/general.dart';

class CreationCont extends GetxController {
  final medlog = logger(CreationCont);
  late GeneralRes generalRes;
  //#region get survey creation types...............................

  Future getSurveyCreationTypes() async {
    generalRes = GeneralRes();
    var data = await GlobalHelpers.apiReq.postdata({}, Addresses.mm);
    medlog.wtf('---GET_SURVEY_TYPES---returned data: $data');
    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
  }

  //#endregion

  SurveyCreationTypes surveyCreationTypes = SurveyCreationTypes();
  var surveyCreationPageController = PageController();
  var surveyNametxtCont = TextEditingController();
  String? torolStr;
  String? counttypeStr;
  String? levelStr;
  String? torolNameStr;
  String? levelNameStr;
  var limitCountVis = false.obs;
  var surveyInputLimitation = TextEditingController();
}
