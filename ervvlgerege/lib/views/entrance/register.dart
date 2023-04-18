import 'dart:async';

import 'package:ervvlgerege/Controllers/entrance.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../MyWidgets/fundamental/option.dart';
import '../../MyWidgets/fundamental/text_heading.dart';
import '../../MyWidgets/fundamental/txt_field.dart';
import '../../global_constants.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static MatchEngine? matchEngine;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var authCont = Get.find<AuthC>();
  List<SwipeItem> formCards = <SwipeItem>[];
  @override
  void initState() {
    formCards.add(SwipeItem(
        //huudas 2
        content: signUpform1(
            'Нэр',
            'Утас',
            'Е-Мэйл',
            authCont.registerName,
            authCont.registerPhone,
            authCont.registerEmail,
            txtForm7(
                'otp баталгаажуулалт хийгдэх тус идвэхтэй ашигладаг утасны дугаар, е-мэйл хаягаа оруулна уу',
                1)),
        onSlideUpdate: (SlideRegion? region) async {},
        likeAction: () {
          SignUp.matchEngine!.rewindMatch();
        },
        nopeAction: () {}));
    formCards.add(SwipeItem(
        content: chooseReciaver(),
        onSlideUpdate: (SlideRegion? region) async {},
        likeAction: () {
          SignUp.matchEngine!.rewindMatch();
        },
        nopeAction: () {
          if (authCont.registerPhone.text == '' ||
              authCont.registerEmail.text == '' ||
              authCont.registerName.text == '') {
            Get.snackbar('Уучлаарай', "Утас, Е-Мэйл талбаруудыг бөглөнө үү!",
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.grey[900],
                margin: const EdgeInsets.all(5));
            SignUp.matchEngine!.rewindMatch();
          }
        }));
    formCards.add(SwipeItem(
        //huudas 3
        content: enterOtp(
          'otp код',
          authCont.registerOtpCode,
          GetX<AuthC>(builder: (cont) {
            if (cont.otpSuccess.value) {
              return const Center(
                child: MyTimer(),
              );
            } else {
              return txtForm7(
                  'otp кодыг илгээхэд асуудал гарлаа утас эсвэл е-мэйл ээ зөв бичсэн эсэхээ шалгана уу!',
                  2);
            }
          }),
        ),
        onSlideUpdate: (SlideRegion? region) async {},
        likeAction: () {
          SignUp.matchEngine!.rewindMatch();
        },
        nopeAction: () {}));
    formCards.add(SwipeItem(
        //huudas 4
        content: signUpform2(
          'Нууц үг',
          'Нууц үг давтах',
          authCont.registerPass,
          authCont.registerPassVerify,
          const SizedBox(),
        ),
        onSlideUpdate: (SlideRegion? region) async {},
        likeAction: () {
          SignUp.matchEngine!.rewindMatch();
        },
        nopeAction: () {}));
    SignUp.matchEngine = MatchEngine(swipeItems: formCards);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        authCont.clearRegister();
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff1755F6), Color(0xff8F00FF)])),
          child: Center(
            child: SizedBox(
              width: Sizes.width * .9,
              height: Sizes.height * .57,
              child: SwipeCards(
                fillSpace: false,
                upSwipeAllowed: false,
                matchEngine: SignUp.matchEngine!,
                itemBuilder: (BuildContext c, int index) {
                  return Container(
                      width: Sizes.width * .9,
                      height: Sizes.height * .57,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: Sizes.width * .9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.leftLong,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          txtForm11('өмнөх')
                                        ],
                                      ),
                                      Container(
                                        width: Sizes.width * .35,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: Mcolors.deepPink,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                      ),
                                      Row(
                                        children: [
                                          txtForm11('цааш'),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            FontAwesomeIcons.rightLong,
                                            size: 12,
                                            color: Colors.grey,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: formCards[index].content,
                          )
                        ],
                      ));
                },
                itemChanged: (SwipeItem item, int index) {
                  switch (index) {
                    case 1:
                      break;
                    case 2:
                      break;
                    case 3:
                      authCont.otpCheck(RouteUnits.register);
                      break;
                    case 4:
                      break;
                  }
                },
                onStackFinished: () {
                  //sign up req
                  authCont.register();
                  Get.toNamed(RouteUnits.login);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//#region screens........................
Widget signUpform1(
    String txtName,
    String txt1Phine,
    String txtEmail,
    TextEditingController txtNameCont,
    TextEditingController txtPontCont,
    TextEditingController txtEmailCont,
    Widget infowidget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const Expanded(
        flex: 2,
        child: SizedBox(),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          child: txtField2(txtNameCont, txtName, () {})),
      Container(
          margin: const EdgeInsets.all(10),
          child: txtField2(txtPontCont, txt1Phine, () {})),
      Container(
          margin: const EdgeInsets.all(10),
          child: txtField2(txtEmailCont, txtEmail, () {})),
      // txtField2(widget.txt2hint),
      Expanded(
          flex: 4,
          child: Center(
              child: Container(
            child: infowidget,
          ))),
    ],
  );
}

Widget signUpform2(
    String txt1hint,
    String txt2hint,
    TextEditingController txt1Cont,
    TextEditingController txt2Cont,
    Widget infowidget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const Expanded(
        flex: 2,
        child: SizedBox(),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          child: txtField2(txt1Cont, txt1hint, () {})),
      Container(
          margin: const EdgeInsets.all(10),
          child: txtField2(txt2Cont, txt2hint, () {})),
      // txtField2(widget.txt2hint),
      Expanded(
          flex: 4,
          child: Center(
              child: Container(
            child: infowidget,
          ))),
    ],
  );
}

Widget enterOtp(
    String txt1hint, TextEditingController txt1Cont, Widget infowidget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const Expanded(
        flex: 2,
        child: SizedBox(),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          child: txtField2(txt1Cont, txt1hint, () {})),
      Expanded(
          flex: 4,
          child: Center(
              child: Container(
            child: infowidget,
          ))),
    ],
  );
}

Widget chooseReciaver() {
  var authCont = Get.find<AuthC>();
  final listdata = <String>['Утас', 'Е-Мэйл'];
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      OptionsHorizontal(
        valueList: listdata,
        selected: '',
        func: (value) {
          authCont.otpReq(RouteUnits.register, value);
        },
      ),
      const SizedBox(
        height: 20,
      ),
      txtForm7('Баталгаажуулах код хүлээж авах төрлөө сонгоорой', 1)
    ],
  );
}

class MyTimer extends StatefulWidget {
  const MyTimer({Key? key}) : super(key: key);

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  int countMinut = 4;
  int countSec = 59;

  late Timer _timerMin;
  late Timer _timerSec;
  @override
  void initState() {
    super.initState();
    _timerMin = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          if (countMinut > 0) {
            countMinut = countMinut - 1;
          }
        });
      }
    });
    _timerSec = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (countMinut > 0) {
            if (countSec > 0) {
              countSec = countSec - 1;
            } else {
              countSec = 59;
            }
          } else {
            //otp dahin ilgeeh btn garch ireh
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timerMin.cancel();
    _timerSec.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            txtForm7('otp амжилттай илгээгдлээ дуусах хугацаа', 1),
            txtTimer('$countMinut : $countSec')
          ],
        ));
  }
}
//#endregion screens.....................