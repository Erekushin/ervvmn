import 'package:ervvlgerege/Controllers/image.dart';
import 'package:ervvlgerege/Controllers/medical.dart';
import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../MyWidgets/MedicalField/doctor_review_card.dart';
import '../../MyWidgets/MedicalField/doctor_type_dard.dart';
import '../../MyWidgets/MedicalField/medical_cards.dart';
import '../../MyWidgets/app/app_bar/appbar_main.dart';
import '../../MyWidgets/app/exit_popup.dart';
import '../../MyWidgets/app/orders.dart';
import '../../MyWidgets/app/search.dart';
import '../../MyWidgets/app/sidebar.dart';
import '../../MyWidgets/fundamental/text_heading.dart';
import '../../MyWidgets/specialist/notSomething.dart';
import '../../global_constants.dart';

class MedicalHome extends StatefulWidget {
  const MedicalHome({Key? key}) : super(key: key);

  @override
  State<MedicalHome> createState() => _MedicalHomeState();
}

class _MedicalHomeState extends State<MedicalHome> {
  GlobalKey<ScaffoldState> menuSidebarKey = GlobalKey<ScaffoldState>();
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 120;
  PageController pageController = PageController(viewportFraction: 0.85);
  var medCont = Get.find<MedicalCont>();
  var proC = Get.find<ProC>();
  @override
  void initState() {
    super.initState();
    GlobalHelpers.auth = proC.userEntranceData.token!;
    GlobalHelpers.myUserId = proC.userEntranceData.userInfo?.id ?? 0;
    GlobalHelpers.chatHelper.connect();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return cloaseTheApp();
      },
      child: Scaffold(
        key: menuSidebarKey,
        appBar: AppbarMain(
          backAction: () {},
          title: 'Эрүүл мэнд',
          menuAction: () {
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
            menuSidebarKey.currentState!.openEndDrawer();
          },
          color: Mcolors.medicalGreen,
        ),
        endDrawer: SidebarGeneral(
          menuAction: () {
            menuSidebarKey.currentState?.closeEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: notSomethingMini(
                    Mcolors.medicalGreen,
                    'онош тодорхойлох',
                    'assets/images/rangers.jpg',
                    'Чиглүүлэх асуумжинд хариулж тохирох эмчтэйгээ холбогдоно уу!',
                    () {}),
              ),
              orders(),
              medicalCards('идвэхтэй картууд'),
              //ontsloh emch nar
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 5),
                      width: Sizes.width * .85,
                      child: headerTxtForm2('Онцлох эмч нар')),
                  SizedBox(
                    width: Sizes.width,
                    height: Sizes.height * .17 + 20,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (c, i) {
                          return InkWell(
                              onTap: () {}, child: doctorReviewCard());
                        }),
                  )
                ],
              ),
              //ontsloh emnelegvvd
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 5),
                      width: Sizes.width * .85,
                      child: headerTxtForm2('Онцлох эмнэлэгүүд')),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: Sizes.height * .25,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: 4,
                        itemBuilder: (context, position) {
                          return _buildPageItem(position);
                        }),
                  )
                ],
              ),

              //Эмчийн төрлүүд
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 5),
                      width: Sizes.width * .85,
                      child: headerTxtForm2('Эмчийн төрлүүд')),
                  SizedBox(
                    width: Sizes.width,
                    height: Sizes.height * .17 + 20,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (c, i) {
                          return doctorTypeCard(
                              'assets/icon/doctor_type_icons/heart.png',
                              'зүрх судас');
                        }),
                  )
                ],
              ),

              //asuumjuud
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (c, i) {
                    return Container(
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 30, right: 30),
                      color: Mcolors.medicalGreen,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: Sizes.width * .9,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(45)),
                          border: Border.all(color: Mcolors.medicalGreen),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: txtForm1('bmi бодох'),
                        ),
                      ),
                    );
                  }),

              SizedBox(
                height: Sizes.height * .07 + 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    String? imagePath;
    if (index == 0) {
      imagePath = "assets/images/hospital1.jpg";
    } else if (index == 1) {
      imagePath = "assets/images/hospital2.jpg";
    } else if (index == 2) {
      imagePath = "assets/images/hospital3.jpg";
    } else if (index == 3) {
      imagePath = "assets/images/hospital4.jpg";
    }
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagePath!), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(30),
              color: index.isEven
                  ? const Color(0xFFC9DAED)
                  : const Color(0xFFE6CF9B)),
        ),
      ),
    );
  }
}
