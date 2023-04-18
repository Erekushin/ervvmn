import 'package:ervvlgerege/MyWidgets/app/app_bar/appbar_square.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';

import '../../MyWidgets/Social/user_profile.dart';
import '../../MyWidgets/app/sidebar.dart';
import '../../MyWidgets/fundamental/buttons.dart';
import '../../MyWidgets/fundamental/text_heading.dart';
import '../../MyWidgets/specialist/service.dart';

class DoctorPro extends StatefulWidget {
  const DoctorPro({super.key});

  @override
  State<DoctorPro> createState() => _DoctorProState();
}

class _DoctorProState extends State<DoctorPro> {
  GlobalKey<ScaffoldState> menuSidebarKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuSidebarKey,
      endDrawer: SidebarGeneral(
        menuAction: () {
          menuSidebarKey.currentState?.closeEndDrawer();
        },
      ),
      appBar: AppbarSquare(
        title: 'Сүхээ',
        color: Mcolors.medicalGreen,
        backAction: () {},
        menuAction: () {
          menuSidebarKey.currentState!.openEndDrawer();
          GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Sizes.height * .15,
              child: Stack(
                children: [
                  //back color
                  Column(
                    children: [
                      Container(
                        height: Sizes.height * .1,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            color: Mcolors.medicalGreen,
                            border: Border.all(
                                color: Mcolors.medicalGreen, width: 0)),
                      ),
                      SizedBox(
                        height: Sizes.height * .05,
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, bottom: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      width: Sizes.width * .9,
                      height: Sizes.height / 6.66,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(90),
                                              bottomRight: Radius.circular(90)),
                                          color: Colors.grey.withOpacity(.15)),
                                      margin: const EdgeInsets.all(7),
                                      width: Sizes.width / 2.11,
                                      height: Sizes.height / 19.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex: 3,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  txtForm2('Үнэлгээ'),
                                                  txtForm3('8.9', 14)
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              size: 17,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      )),
                                  CircleAvatar(
                                    radius: Sizes.height / 31,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: Sizes.height / 31 - 1,
                                      backgroundColor:
                                          Colors.grey.withOpacity(.15),
                                      child: CircleAvatar(
                                        radius: Sizes.height / 31 - 2,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: Sizes.height / 31 - 3,
                                          backgroundColor:
                                              Colors.grey.withOpacity(.15),
                                          child: userProPic(
                                              'https://i.pinimg.com/564x/7c/2f/47/7c2f478de45b85fa9b49c220a8e28f7e.jpg',
                                              Sizes.height / 31 - 4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              generalBtn(Mcolors.medicalGreen, 'Дагах', () {}),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_vert))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              txtForm1('Сүхээ : 120 дагагч : 56 контент'),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            serviceOfSpecialist(() {}),
            const SizedBox(
              height: 50,
            ),
            greyTestBtn('Статус: Эмч', () {}),
            greyTestBtn('Чиглэл: Дотор', () {}),
            greyTestBtn('Харъяалал: Интертед эмнэлэг', () {}),
            greyTestBtn('Ажлын туршлага: 5 жил', () {}),
          ],
        ),
      ),
    );
  }
}
