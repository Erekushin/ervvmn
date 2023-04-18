import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../MyWidgets/app/app_bar/appbar_main.dart';
import '../../MyWidgets/app/sidebar.dart';
import '../../MyWidgets/fundamental/m_icons.dart';
import '../../MyWidgets/fundamental/text_heading.dart';

class WalletMain extends StatefulWidget {
  const WalletMain({Key? key}) : super(key: key);

  @override
  State<WalletMain> createState() => _WalletMainState();
}

class _WalletMainState extends State<WalletMain> {
  GlobalKey<ScaffoldState> menuSidebarKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppbarMain(
          backAction: () {},
          title: 'Хэтэвч',
          menuAction: () {
            menuSidebarKey.currentState!.openEndDrawer();
          },
          color: Mcolors.geregeBlue,
        ),
        key: menuSidebarKey,
        endDrawer: SidebarGeneral(
          menuAction: () {
            menuSidebarKey.currentState?.closeEndDrawer();
          },
        ),
        body: Column(
          children: [
            //vldegdel
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Colors.grey.shade400))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //vldegdel
                    Container(
                      width: Sizes.width * .72,
                      height: Sizes.height * .1,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(90))),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: txtForm3('14,500₮', 40)),
                          const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ),
                    //qr
                    Container(
                        padding: const EdgeInsets.all(10),
                        width: Sizes.width * .18,
                        height: Sizes.height * .1,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(45),
                                bottomLeft: Radius.circular(45))),
                        child: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            FontAwesomeIcons.qrcode,
                            color: Colors.black,
                            size: 20,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            //gvilgeenii tvvh
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xff0139FF).withOpacity(.1),
                        const Color(0xff8F00FF).withOpacity(.1),
                      ],
                    )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(),
                            walletBtn(FontAwesomeIcons.arrowUpFromBracket,
                                'цэнэглэх'),
                            walletBtn(FontAwesomeIcons.download, 'татах'),
                            walletBtn(FontAwesomeIcons.fileLines, 'нэхэмжлэх'),
                            walletBtn(FontAwesomeIcons.repeat, 'шилжүүлэх'),
                            const SizedBox()
                          ],
                        )),
                    Expanded(
                      flex: 5,
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                    color: Colors.grey.shade400,
                                    inset: true)
                              ]),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Sizes.width * .9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: txtForm8('Баримт')),
                                      TextButton(
                                          onPressed: () {},
                                          child: txtForm8('Нэхэмлэл')),
                                      TextButton(
                                          onPressed: () {},
                                          child: txtForm8('Гүйлгээ')),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  width: Sizes.width * .9,
                                  height: 200,
                                  child: PageView(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    const Expanded(flex: 1, child: SizedBox())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget walletBtn(IconData icon, String txt) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(90)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 5,
                offset: const Offset(0, 5))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon2(icon),
          const SizedBox(
            height: 5,
          ),
          txtForm2(txt)
        ],
      ),
    );
  }
}
