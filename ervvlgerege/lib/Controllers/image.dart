import 'dart:convert';
import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:get/get.dart';
import '../Models/general.dart';
import '../global_constants.dart';

class ImageCont extends GetxController {
  GeneralRes generalRes = GeneralRes();
  Future imageUpload() async {
    var data = await GlobalHelpers.apiReq.uploadImage(
        GlobalHelpers.imageHelper.imageFilereq,
        '${Addresses.mArea}file/upload');
    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
    if (generalRes.code == '200') {
      Get.find<ProC>().userEntranceData.userInfo!.profilePicture =
          generalRes.result.toString();
    }
  }
}
