import 'dart:ui';

import 'package:ervvlgerege/Controllers/entrance.dart';
import 'package:ervvlgerege/Helpers/logging.dart';
import 'package:ervvlgerege/Helpers/scroll_behavior.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../../MyWidgets/fundamental/buttons.dart';
import '../../MyWidgets/fundamental/text_heading.dart';
import '../../MyWidgets/fundamental/txt_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final medlog = logger(Login);
  var authCont = Get.find<AuthC>();
  final LocalAuthentication auth = LocalAuthentication();
  BioSupportState bioSupportState = BioSupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;

  double bubble1Top = -1.1;
  double bubble1Left = 4.5;

  double bubble2Top = -0.1;
  double bubble2Left = -0.9;

  double bubble3Top = 0.2;
  double bubble3Left = 0.8;

  double bubble4Top = 0.4;
  double bubble4Left = -0.6;

  double bubble5Top = 1.2;
  double bubble5Left = -1.4;
  late AnimationController animationCont;
  final ColorTween bubbleColor1 = ColorTween(
      begin: const Color.fromARGB(255, 38, 84, 252),
      end: const Color.fromARGB(255, 178, 81, 252));
  final ColorTween bubbleColor2 = ColorTween(
      begin: const Color.fromARGB(255, 178, 81, 252),
      end: const Color.fromARGB(255, 38, 84, 252));
  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => bioSupportState = isSupported
              ? BioSupportState.supported
              : BioSupportState.unsupported),
        );
    animationCont =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    animationCont.addListener(() {
      setState(() {
        bubble1Top = -1.1 + (animationCont.value / 9);
        bubble1Left = 4.5 - (animationCont.value / 9);

        bubble2Top = -0.1 + (animationCont.value / 6);
        bubble2Left = -0.9 + (animationCont.value / 6);

        bubble3Top = 0.2 + (animationCont.value / 4);
        bubble3Left = 0.8 - (animationCont.value / 4);

        bubble4Top = 0.4 - (animationCont.value / 3);
        bubble4Left = -0.6 + (animationCont.value / 3);

        bubble5Top = 1.2 - (animationCont.value / 8);
        bubble5Left = -1.4 + (animationCont.value / 8);
      });
    });
    animationCont.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationCont.dispose();
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      medlog.e(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
    if (_canCheckBiometrics ?? false) {
      _getAvailableBiometrics();
    }
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      medlog.e(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
    if (_availableBiometrics!.isNotEmpty) {
      if (_availableBiometrics!.contains(BiometricType.strong) ||
          _availableBiometrics!.contains(BiometricType.fingerprint)) {
        try {
          final bool didAuthenticate = await auth.authenticate(
              localizedReason: 'Please authenticate to show account balance');

          if (didAuthenticate) {
            authCont.passWord.text = GlobalHelpers.pass;
            authCont.loginname.text = GlobalHelpers.name;
            authCont.login();
          }
        } on PlatformException catch (e) {
          medlog.e(e.code);
        }
      }
    }
  }

  // Future<void> _authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       isAuthenticating = true;
  //       authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Let OS determine authentication method',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //       ),
  //     );
  //     setState(() {
  //       isAuthenticating = false;
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //     setState(() {
  //       isAuthenticating = false;
  //       authorized = 'Error - ${e.message}';
  //     });
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   setState(
  //       () => authorized = authenticated ? 'Authorized' : 'Not Authorized');
  // }

  // Future<void> _authenticateWithBiometrics() async {
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       isAuthenticating = true;
  //       authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason:
  //           'Scan your fingerprint (or face or whatever) to authenticate',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //         biometricOnly: true,
  //       ),
  //     );
  //     setState(() {
  //       isAuthenticating = false;
  //       authorized = 'Authenticating';
  //     });
  //   } on PlatformException catch (e) {
  //     medlog.e(e);
  //     setState(() {
  //       isAuthenticating = false;
  //       authorized = 'Error - ${e.message}';
  //     });
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   final String message = authenticated ? 'Authorized' : 'Not Authorized';
  //   setState(() {
  //     authorized = message;
  //   });
  // }

  // Future<void> _cancelAuthentication() async {
  //   await auth.stopAuthentication();
  //   setState(() => isAuthenticating = false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: ScrollConfiguration(
          behavior: ScrollBehave(),
          child: SingleChildScrollView(
              child: SizedBox(
                  height: Sizes.height,
                  child: Stack(
                    children: [
                      lavaBubble(320, 320, bubble1Top, bubble1Left),
                      lavaBubble(120, 120, bubble2Top, bubble2Left),
                      lavaBubble(70, 70, bubble3Top, bubble3Left),
                      lavaBubble(90, 90, bubble4Top, bubble4Left),
                      lavaBubble(210, 210, bubble5Top, bubble5Left),
                      Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              transParentContainer(
                                  300,
                                  50,
                                  txtField1('name . . .', authCont.loginname),
                                  30,
                                  Alignment.centerLeft),
                              transParentContainer(
                                  300,
                                  50,
                                  txtFieldPass('pass . . .', authCont.passWord),
                                  30,
                                  Alignment.centerLeft),
                              SizedBox(
                                width: 310,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        authCont.login();
                                      },
                                      child: transParentContainer(
                                          145,
                                          50,
                                          txtForm4('Login'),
                                          0,
                                          Alignment.center),
                                    ),
                                    InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        splashColor:
                                            Colors.grey.withOpacity(0.01),
                                        onTap: () {
                                          authCont.nuutsVgSergeehArgaSongoh
                                              .value = true;
                                          Get.toNamed(RouteUnits.forgetpass);
                                        },
                                        child: transParentContainer(
                                            145,
                                            50,
                                            txtForm4('forgetten password'),
                                            0,
                                            Alignment.center))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      //finger print tap
                                      //nogoo file maani bgaa esehiig shalgah

                                      onTap: () async {
                                        if (GlobalHelpers.pass != '') {
                                          _checkBiometrics();
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  SimpleDialog(
                                                    title: txtForm8(
                                                        'Хурууны хээн нэвтрэлтийг идвэхжүүлхүү?'),
                                                    children: [
                                                      popUpbtn(
                                                          'идвэхжүүлэх',
                                                          FontAwesomeIcons
                                                              .check, () {
                                                        if (bioSupportState ==
                                                            BioSupportState
                                                                .unknown) {
                                                          Get.snackbar(
                                                              'Уучлаарай',
                                                              "Хурууны хээ уншигчийн төрөл таарахгүй байна!",
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM,
                                                              colorText:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      900],
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5));
                                                        } else if (bioSupportState ==
                                                            BioSupportState
                                                                .supported) {
                                                          GlobalHelpers
                                                              .workingWithFile
                                                              .addNewItem(
                                                                  'isFingering',
                                                                  'true');

                                                          Get.snackbar(
                                                              'Боломжтой',
                                                              "Та эхний удаа нэр, нууц үгээ хийж нэвтэрнэ үү!",
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM,
                                                              colorText:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      900],
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5));
                                                        } else {
                                                          Get.snackbar(
                                                              'Уучлаарай',
                                                              "Хурууны хээ уншигчийг ачааллахад алдаа гарлаа!",
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM,
                                                              colorText:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      900],
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5));
                                                        }
                                                        Navigator.pop(context);
                                                      }),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          generalBtn(
                                                              Mcolors
                                                                  .geregeBlue,
                                                              'хаах', () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                        ],
                                                      )
                                                    ],
                                                  ));
                                        }
                                      },
                                      child: transParentContainer(
                                          50,
                                          50,
                                          const Icon(
                                            FontAwesomeIcons.fingerprint,
                                            color: Colors.grey,
                                          ),
                                          0,
                                          Alignment.center),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(children: [
                            transParentContainer(
                                220,
                                80,
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    otherAccLoginBtn(
                                        () {}, 'assets/icon/google.png'),
                                    otherAccLoginBtn(
                                        () {}, 'assets/icon/facebook.png'),
                                    otherAccLoginBtn(
                                        () {}, 'assets/icon/gerege.jpg'),
                                  ],
                                ),
                                10,
                                Alignment.centerLeft),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.grey.withOpacity(0.01),
                              onTap: () {
                                Get.toNamed(RouteUnits.register);
                              },
                              child: transParentContainer(
                                  220,
                                  50,
                                  txtForm4('Create a new Account'),
                                  0,
                                  Alignment.center),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ])
                        ],
                      )),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              margin: const EdgeInsets.all(50),
                              child: headerTxtForm5('Marea')))
                    ],
                  ))),
        ));
  }

  Widget lavaBubble(
      double width, double height, double topAlign, double leftAlign) {
    return AnimatedAlign(
      duration: const Duration(seconds: 3),
      alignment: Alignment(leftAlign, topAlign),
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: width,
        height: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  bubbleColor1.evaluate(animationCont)!,
                  bubbleColor2.evaluate(animationCont)!
                ])),
      ),
    );
  }

  Widget transParentContainer(double width, double height, Widget child,
      double leftmargin, Alignment childAlign) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 4,
              offset: const Offset(0, 0),
              blurStyle: BlurStyle.outer,
            )
          ]),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Align(
            alignment: childAlign,
            child: Container(
                margin: EdgeInsets.only(left: leftmargin), child: child),
          ),
        ),
      ),
    );
  }

  Widget otherAccLoginBtn(Function func, String url) {
    return InkWell(
      onTap: () {
        func;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage(url),
          ),
          const SizedBox(width: 10),
          txtForm4('sign up with google')
        ],
      ),
    );
  }
}
