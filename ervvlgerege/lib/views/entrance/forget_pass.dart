import 'package:ervvlgerege/Controllers/entrance.dart';
import 'package:ervvlgerege/MyWidgets/fundamental/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../MyWidgets/fundamental/option.dart';
import '../../MyWidgets/fundamental/text_heading.dart';
import '../../MyWidgets/fundamental/txt_field.dart';
import '../../global_constants.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final argu = Get.arguments ?? '';
  var authCont = Get.find<AuthC>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        authCont.hideAllchilaka();
        authCont.clearRegister();
        return true;
      },
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Center(child: GetX<AuthC>(builder: (cont) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  box('Нууц үг сэргээх аргаа сонгоно уу', chilaka1(),
                      cont.nuutsVgSergeehArgaSongoh.value),
                  box('Шинэ утасны дугаар оруулах', chilakaPhone(),
                      cont.utasShinechileh.value),
                  box('Шинэ email хаягаа оруулах', chilakaEmail(),
                      cont.emailShinechileh.value),
                  box(
                      'Бүртгэлтэй утасны дугаараа оруулна уу',
                      chilaka2(authCont.registerPhone, () {
                        authCont.otpReq(RouteUnits.forgetpass, 'Утас');
                      }),
                      cont.otpRecieverPhone.value),
                  box(
                      'Бүртгэлтэй е-мэйл хаягаа оруулна уу',
                      chilaka2(authCont.registerEmail, () {
                        authCont.otpReq(RouteUnits.forgetpass, 'Е-Мэйл');
                      }),
                      cont.otpRecieverEmail.value),
                  box(
                      'утасны дугаарт ирсэн нууц дугаарыг оруулна уу',
                      chilaka2(authCont.registerOtpCode, () {
                        authCont.otpCheck(RouteUnits.forgetpass);
                      }),
                      cont.otpOruulahphone.value),
                  box(
                      'утасны дугаарт ирсэн нууц дугаарыг оруулна уу',
                      chilaka2(authCont.registerOtpCode, () {
                        authCont.otpCheck(RouteUnits.forgetpass);
                      }),
                      cont.otpOruulahphonenew.value),
                  box(
                      'email -д ирсэн нууц дугаарыг оруулна уу',
                      chilaka2(authCont.registerOtpCode, () {
                        authCont.otpCheck(RouteUnits.forgetpass);
                      }),
                      cont.otpOruulahEmail.value),
                  box(
                      'шинэ email -д ирсэн нууц дугаарыг оруулна уу',
                      chilaka2(authCont.registerOtpCode, () {
                        authCont.otpCheck('1');
                      }),
                      cont.otpOruulahEmailnew.value),
                  box('Нууц дугаар шинэчилэх', chilaka3(),
                      cont.nuutsVgshinechileh.value),
                ],
              );
            })),
          ),
        ),
      ),
    );
  }

  Widget box(String title, Widget chilaka, bool visibility) {
    return Visibility(
      visible: visibility,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            width: Sizes.width * .9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.black26)),
            child: Column(
              children: [
                txtForm5(title),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: Sizes.width * .8,
                  height: 1,
                  color: Colors.black45,
                ),
                chilaka
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget chilaka1() {
    var listdata = <String>['Утас', 'Е-Мэйл'];
    return SizedBox(
        child: OptionsHorizontal(
            valueList: listdata,
            selected: '',
            func: (value) {
              if (value == "Утас") {
                authCont.otpRecieverPhone.value = true;
                authCont.otpRecieverEmail.value = false;
              } else if (value == "Е-Мэйл") {
                authCont.otpRecieverEmail.value = true;
                authCont.otpRecieverPhone.value = false;
              }
            }));
  }

  Widget chilaka2(TextEditingController txtCont, Function func) {
    return Column(
      children: [
        Container(
          child: txtField2(txtCont, '. . .', () {}),
        ),
        const SizedBox(
          height: 5,
        ),
        generalBtn(Mcolors.geregeBlue, 'болсон', func)
      ],
    );
  }

  Widget chilaka3() {
    return SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            txtField2(authCont.registerPass, 'Нууц үг', () {}),
            const SizedBox(
              height: 20,
            ),
            txtField2(authCont.registerPassVerify, 'Нууц үг давтах', () {}),
            generalBtn(Mcolors.geregeBlue, 'болсон', () {
              authCont.forgetPass();
            }),
            // txtField2(widget.txt2hint),
            const Expanded(flex: 4, child: SizedBox()),
          ],
        ));
  }

  Widget chilakaPhone() {
    return SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            txtField2(authCont.registerPhone, argu, () {}),
            // txtField2(widget.txt2hint),
            Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      generalBtn(Mcolors.geregeBlue, 'otp авах', () {
                        authCont.otpReq(RouteUnits.forgetpass, 'Утас');
                        authCont.otpOruulahphonenew.value = true;
                      })
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget chilakaEmail() {
    return SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            txtField2(authCont.registerEmail, argu, () {}),
            // txtField2(widget.txt2hint),
            Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      generalBtn(Mcolors.geregeBlue, 'otp авах', () {
                        authCont.otpReq('1', 'Е-Мэйл');
                        authCont.otpOruulahEmailnew.value = true;
                      })
                    ],
                  ),
                )),
          ],
        ));
  }
}
