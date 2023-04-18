import 'package:ervvlgerege/Controllers/chat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controllers/content/survey/survey_creation.dart';
import '../../Helpers/logging.dart';
import '../../global_constants.dart';
import '../../views/content/surveyCreation/create_survey.dart';

// ignore: must_be_immutable
class MyBottomNavbar extends StatefulWidget {
  MyBottomNavbar({Key? key, required this.comingKey}) : super(key: key);
  BottomNavbarKeys comingKey = BottomNavbarKeys.home;
  @override
  State<MyBottomNavbar> createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {
  final medlog = logger(MyBottomNavbar);
  var chatC = Get.find<ChatC>();
  var surveyCreation = Get.find<CreationCont>();
  final List<IconData> listOfIcons = [
    FontAwesomeIcons.houseChimney,
    FontAwesomeIcons.solidUser,
    FontAwesomeIcons.circlePlus,
    FontAwesomeIcons.handHoldingMedical,
    FontAwesomeIcons.solidComments,
  ];
  BottomNavbarKeys? _currentKey;
  routing(BottomNavbarKeys key) {
    switch (key) {
      case BottomNavbarKeys.home:
        Get.offAllNamed(RouteUnits.medicalhome);
        break;
      case BottomNavbarKeys.profile:
        Get.offAllNamed(RouteUnits.profile);
        break;
      case BottomNavbarKeys.addPost:
        surveyCreation.getSurveyCreationTypes();
        SCargubody sCargubody = SCargubody();
        sCargubody.initialPage = 1;
        sCargubody.fromRoute = 'll';
        Get.to(const SurveyCreation(), arguments: sCargubody);
        break;
      case BottomNavbarKeys.medicalHome:
        break;
      case BottomNavbarKeys.chat:
        try {
          chatC.getConvs();
        } catch (e) {
          medlog.e('---CHAT GET CONVERSATIONS---: $e');
        }
        Get.offAllNamed(RouteUnits.chathome);
        break;
      case BottomNavbarKeys.hideNavBar:
        break;
      case BottomNavbarKeys.hideSideBar:
        break;
    }
    _currentKey = key;
  }

  @override
  Widget build(BuildContext context) {
    _currentKey = widget.comingKey;
    return SizedBox(
      child: Container(
          padding: const EdgeInsets.only(left: 12, right: 20),
          margin: EdgeInsets.all(Sizes.width * .05),
          height: Sizes.height * .07,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomNavbarIcon(BottomNavbarKeys.home),
              bottomNavbarIcon(BottomNavbarKeys.profile),
              bottomNavbarIcon(BottomNavbarKeys.addPost),
              bottomNavbarIcon(BottomNavbarKeys.medicalHome),
              bottomNavbarIcon(BottomNavbarKeys.chat)
            ],
          )),
    );
  }

  Widget bottomNavbarIcon(BottomNavbarKeys iconKey) {
    return InkWell(
      onTap: () {
        widget.comingKey = iconKey;
        setState(() {
          routing(iconKey);
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastLinearToSlowEaseIn,
            margin: EdgeInsets.only(
                bottom: iconKey == _currentKey ? 0 : Sizes.width * .029),
            width: Sizes.width * .13,
            height: iconKey == _currentKey ? Sizes.height * .01 : 0,
            decoration: BoxDecoration(
              color: iconKey == BottomNavbarKeys.home
                  ? Mcolors.medicalGreen
                  : Mcolors.geregeBlue,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          Icon(
            listOfIcons[iconKey.index],
            size: Sizes.height * .025,
            color: iconKey == _currentKey
                ? iconKey == BottomNavbarKeys.home
                    ? Mcolors.medicalGreen
                    : Mcolors.geregeBlue
                : Colors.black38,
          ),
          SizedBox(
            height: Sizes.height * .01,
          )
        ],
      ),
    );
  }
}
