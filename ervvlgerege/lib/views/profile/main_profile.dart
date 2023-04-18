import 'package:flutter/material.dart';
import '../../MyWidgets/MedicalField/daily_input.dart';
import '../../MyWidgets/MedicalField/medical_cards.dart';
import '../../MyWidgets/Social/user_profile.dart';
import '../../MyWidgets/app/app_bar/appbar_square.dart';
import '../../MyWidgets/app/moreActions.dart';
import '../../MyWidgets/app/orders.dart';
import '../../MyWidgets/app/sidebar.dart';
import '../../MyWidgets/fundamental/my_switcher.dart';
import '../../MyWidgets/fundamental/text_heading.dart';
import '../../MyWidgets/specialist/task_calendar.dart';
import '../../global_constants.dart';
import 'package:get/get.dart';
import '../../Controllers/profile.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({Key? key}) : super(key: key);
  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  GlobalKey<ScaffoldState> menuSidebarKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var proCont = Get.find<ProC>();
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RouteUnits.medicalhome);
        GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
        return true;
      },
      child: Scaffold(
        key: menuSidebarKey,
        endDrawer: SidebarGeneral(
          menuAction: () {
            menuSidebarKey.currentState?.closeEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.profile);
          },
        ),
        appBar: AppbarSquare(
          title: 'Profile',
          menuAction: () {
            menuSidebarKey.currentState!.openEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
          },
          backAction: () {
            Get.offAllNamed(RouteUnits.medicalhome);
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
          },
          color: Mcolors.geregeBlue,
        ),
        body: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              //ProCard
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
                              color: Mcolors.geregeBlue,
                              border: Border.all(
                                  color: Mcolors.geregeBlue, width: 0)),
                        ),
                        SizedBox(
                          height: Sizes.height * .05,
                        )
                      ],
                    ),
                    Align(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(90),
                                                    bottomRight:
                                                        Radius.circular(90)),
                                            color:
                                                Colors.grey.withOpacity(.15)),
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
                                                onTap: () {
                                                  Get.toNamed(
                                                      RouteUnits.wallet);
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    txtForm2('Хэтэвч'),
                                                    txtForm3('14,500₮', 14)
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
                                      radius: Sizes.height / 32,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: Sizes.height / 32 - 1,
                                        backgroundColor:
                                            Colors.grey.withOpacity(.15),
                                        child: CircleAvatar(
                                          radius: Sizes.height / 32 - 2,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: Sizes.height / 32 - 3,
                                            backgroundColor:
                                                Colors.grey.withOpacity(.15),
                                            child: userProPic(
                                                'https://i.pinimg.com/564x/7c/2f/47/7c2f478de45b85fa9b49c220a8e28f7e.jpg',
                                                Sizes.height / 31),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      GlobalHelpers.bottomnavbarSwitcher
                                          .add(BottomNavbarKeys.hideNavBar);
                                      Get.to(() => MoreActions(
                                            func: () {
                                              Get.back();
                                            },
                                          ));
                                    },
                                    icon: const Icon(Icons.more_vert))
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  Get.toNamed(RouteUnits.taskCalendar);
                                },
                                child: const TaskCalendar()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                txtForm1('Сүхээ : 120 дагагч : 56 контент'),
                                MySwitcher(
                                  keyWord: 'specialist',
                                  switcherValue:
                                      proCont.specialistSwitcher.value,
                                  func: () {},
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //zahialsan tsaguud
              orders(),
              //Emchilgeenii card
              medicalCards('Эмчилгээний карт'),
              //daily input
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 5),
                        width: Sizes.width * .85,
                        child: headerTxtForm2('Миний үзүүлэлтүүд')),
                    Container(
                      margin: EdgeInsets.only(bottom: Sizes.height * .08),
                      width: Sizes.width * .9,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            return const DailyInput();
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
