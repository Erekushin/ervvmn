import 'dart:async';
import 'dart:convert';

import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:ervvlgerege/Helpers/logging.dart';
import 'package:ervvlgerege/Models/general.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import '../Models/userInfo/user_info.dart';
import '../views/entrance/register.dart';

class AuthC extends GetxController {
  final medlog = logger(AuthC);
  late GeneralRes generalRes;
  //#region register..............................
  var registerName = TextEditingController();
  var registerPhone = TextEditingController();
  var registerEmail = TextEditingController();
  var registerOtpCode = TextEditingController();
  var registerPass = TextEditingController();
  var registerPassVerify = TextEditingController();

  clearRegister() {
    registerName.clear();
    registerPhone.clear();
    registerEmail.clear();
    registerOtpCode.clear();
    registerPass.clear();
    registerPassVerify.clear();
  }

  Map<String, dynamic> registerB() {
    var bytes = utf8.encode(registerPassVerify.text);
    var hash = sha256.convert(bytes);
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = registerName.text;
    data['email'] = registerEmail.text;
    data['phone'] = registerPhone.text;
    data['is_email_activated'] = registerEmail.text.isEmpty ? 0 : 1;
    data['is_phone_activated'] = registerPhone.text.isEmpty ? 0 : 1;
    data['code'] = registerOtpCode.text;
    data['password'] = hash.toString();
    data['repeat_password'] = hash.toString();
    return data;
  }

  Future register() async {
    generalRes = GeneralRes();
    var data = await GlobalHelpers.apiReq.postdata(
        registerB(), '${Addresses.mArea}auth/public/register/identity/step2');
    medlog.wtf(
        '----REGISTER-----Sent body: ${registerB()}......Returned Data:$data');

    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
    switch (generalRes.code) {
      case '200':
        Get.snackbar('Бүртгэл амжилттай үүслээ', "Welcome to Gerege family",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: const EdgeInsets.all(5));
        clearRegister();
        break;
    }
  }
  //#endregion register.......................................

  //#region login................................
  bool loginWithFingerPrint = false;
  var loginname = TextEditingController();
  var passWord = TextEditingController();
  Map<String, dynamic> loginB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    var bytes = utf8.encode(passWord.text);
    var hash = sha256.convert(bytes);
    data['search_text'] = loginname.text;
    data['password'] = hash.toString();
    data['device_token'] = GlobalHelpers.deviceToken;
    return data;
  }

  Future login() async {
    generalRes = GeneralRes();
    if (passWord.text.isEmpty || loginname.text.isEmpty) {
      Get.snackbar('Талбарууд хоосон байна', "",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900],
          margin: const EdgeInsets.all(5));
    } else {
      try {
        var data = await GlobalHelpers.apiReq
            .postdata(loginB(), '${Addresses.mArea}auth/public/login/password');
        medlog.wtf(
            '---LOGIN--- Sent body: ${loginB()}....................Returned Data:$data');
        generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
      } catch (e) {
        medlog.e(e);
      }
      switch (generalRes.code) {
        case '200':
          if (GlobalHelpers.ifFingering == true && GlobalHelpers.pass == '') {
            GlobalHelpers.workingWithFile.addNewItem('isFingering', 'true');
            GlobalHelpers.workingWithFile.addNewItem('pass', passWord.text);
            GlobalHelpers.workingWithFile.addNewItem('name', loginname.text);
          }
          Get.find<ProC>().userEntranceData =
              UserEntranceData.fromJson(generalRes.result);
          GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
          Get.offAllNamed(RouteUnits.medicalhome);
          break;
        case '500':
          if (generalRes.message == 'PASSWORD_NOT_MATCH') {
            Get.snackbar('Уучлаарай', "Password таарахгүй байна.",
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.grey[900],
                margin: const EdgeInsets.all(5));
          }
          if (generalRes.message == 'NOT_REGISTERED_USER') {
            Get.snackbar('Уучлаарай', "Бүртгүүлээгүй хэрэглэгч байна.",
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.grey[900],
                margin: const EdgeInsets.all(5));
          }
          break;
      }
    }
  }

  //#endregion login.............................

  //#region forget pass...............................

  //forget pass deerh chilaka nuud
  var nuutsVgSergeehArgaSongoh = false.obs;
  var otpRecieverPhone = false.obs;
  var otpRecieverEmail = false.obs;
  var otpOruulahphone = false.obs;
  var otpOruulahEmail = false.obs;
  var nuutsVgshinechileh = false.obs;
  var otpOruulahphonenew = false.obs;
  var otpOruulahEmailnew = false.obs;
  var utasShinechileh = false.obs;
  var emailShinechileh = false.obs;

  hideAllchilaka() {
    nuutsVgSergeehArgaSongoh.value = false;
    otpRecieverPhone.value = false;
    otpRecieverEmail.value = false;
    otpOruulahphone.value = false;
    otpOruulahEmail.value = false;
    nuutsVgshinechileh.value = false;
    otpOruulahphonenew.value = false;
    otpOruulahEmailnew.value = false;
    utasShinechileh.value = false;
    emailShinechileh.value = false;
  }

  Map<String, dynamic> forgetPassB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    var bytes = utf8.encode(registerPassVerify.text);
    var hash = sha256.convert(bytes);
    if (otpIdentity == "Утас") {
      data['identity'] = registerPhone.text;
    } else if (otpIdentity == "Е-Мэйл") {
      data['identity'] = registerEmail.text;
    }
    data['otp_code'] = registerOtpCode.text;
    data['password'] = hash.toString();
    data['password_repeat'] = hash.toString();
    return data;
  }

  Future forgetPass() async {
    var data = await GlobalHelpers.apiReq.postdata(
        forgetPassB(), '${Addresses.mArea}auth/public/forget/password');
    medlog.wtf(
        '----GET NEW PASS---- : sent body : ${forgetPassB()}..........returned data : $data');
    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
    switch (generalRes.code) {
      case '200':
        Get.snackbar('Амжилттай', "шинэ нууц үгийг бүртгэж авлаа",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: const EdgeInsets.all(5));
        hideAllchilaka();
        clearRegister();
        Get.toNamed(RouteUnits.login);
        break;
    }
  }
  //#endregion forget pass..................................

  //#region opt....................................
  var otpSuccess = false.obs;
  late String otpIdentity;
  Map<String, dynamic> otpReqB(String identity) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (identity == "Утас") {
      data['identity'] = registerPhone.text;
    } else if (identity == "Е-Мэйл") {
      data['identity'] = registerEmail.text;
    }
    data['code'] = registerOtpCode.text;
    return data;
  }

  Future otpReq(String routeKey, String identity) async {
    otpIdentity = identity;
    String reqRoute = '';
    if (routeKey == RouteUnits.register) {
      reqRoute = 'register/identity/step1';
    } else if (routeKey == RouteUnits.forgetpass || routeKey == '1') {
      reqRoute = 'otp/resend';
    }
    var data = await GlobalHelpers.apiReq
        .postdata(otpReqB(identity), '${Addresses.mArea}auth/public/$reqRoute');
    medlog.wtf(
        '----OTP REQUEST--- : sent body : ${otpReqB(identity)}..........returned data : $data');
    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
    switch (generalRes.code) {
      case '200':
        otpSuccess.value = true;
        if (routeKey == "/forgetpass") {
          if (identity == "Утас") {
            otpOruulahphone.value = true;
          } else if (identity == "Е-Мэйл") {
            otpOruulahEmail.value = true;
          }
        }
        Get.snackbar('Otp амжилттай илгээгдлээ', "",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: const EdgeInsets.all(5));
        break;
      case '500':
        if (generalRes.message == 'ALREADY_REGISTERED_USER') {
          Get.snackbar('Уучлаарай',
              "Та бүртгэгдээгүй утасны дугаар, Е-Мэйл ашиглана уу!",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: const EdgeInsets.all(5));
          SignUp.matchEngine!.rewindMatch();
          SignUp.matchEngine!.rewindMatch();
        }
        if (generalRes.message == 'INVALID_IDENTITY') {
          Get.snackbar('Уучлаарай', "Утасны дугаар, Е-Мэйл буруу байна!",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: const EdgeInsets.all(5));
          registerEmail.clear();
          registerPhone.clear();
          SignUp.matchEngine!.rewindMatch();
          SignUp.matchEngine!.rewindMatch();
        }
        if (generalRes.message == 'MESSAGEWAITSECONDS') {
          Get.snackbar('Otp хэдийн илгээгдсэн байна!', "",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: const EdgeInsets.all(5));
        }
        break;
      case '400':
        //otp ee avch chadaagv bolhoor avch chadsangvv gedegiig ni haruulah
        break;
    }
  }

  Future otpCheck(String routeKey) async {
    var data = await GlobalHelpers.apiReq.postdata(
        otpReqB(otpIdentity), '${Addresses.mArea}auth/public/otp/check');
    medlog.wtf(
        '---OTP CHECK--- : sent body : ${otpReqB(otpIdentity)}..........returned data : $data');
    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
    switch (generalRes.code) {
      case '200':
        Get.snackbar('Баталгаажууллаа', "",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: const EdgeInsets.all(5));
        switch (routeKey) {
          case '1':
            changePhoneEmail();
            break;
        }
        if (routeKey == RouteUnits.forgetpass) {
          nuutsVgshinechileh.value = true;
        }
        break;
      case '500':
        if (generalRes.message == 'INVALID_OTP_CODE') {
          Get.snackbar('Уучлаарай', "Баталгаажуулах код буруу байна!",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: const EdgeInsets.all(5));
          if (routeKey == RouteUnits.register) {
            SignUp.matchEngine!.rewindMatch();
          }
        }
        break;
      case '400':
        break;
    }
  }

  //#endregion otp..................................

  //#region change phone and email...........................
  Map<String, dynamic> changePhoneEmailB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = GlobalHelpers.myUserId;
    if (otpIdentity == "Утас") {
      data['identity'] = registerPhone.text;
    } else if (otpIdentity == "Е-Мэйл") {
      data['identity'] = registerEmail.text;
    }
    data['code'] = registerOtpCode.text;
    return data;
  }

  Future changePhoneEmail() async {
    generalRes = GeneralRes();
    var data = await GlobalHelpers.apiReq.postdata(
        changePhoneEmailB(), '${Addresses.mArea}auth/user/auth/phone/email');
    medlog.wtf(
        '---CHANGE PHONE OR EMAIL---: sent body: ${changePhoneEmailB()}..............returned data $data');
    generalRes = GeneralRes.fromJson(jsonDecode(data.toString()));
    switch (generalRes.code) {
      case "200":
        if (otpIdentity == "Утас") {
          Get.find<ProC>().userEntranceData.userInfo!.email =
              registerPhone.text;
        } else if (otpIdentity == "Е-Мэйл") {
          Get.find<ProC>().userEntranceData.userInfo!.phone =
              registerEmail.text;
        }
        hideAllchilaka();
        clearRegister();
        Get.snackbar('Амжилттай солигдлоо', "",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: const EdgeInsets.all(5));
        Get.toNamed(RouteUnits.profile);
        break;
    }
  }

  //#endregion change phone and mail..............................
}
