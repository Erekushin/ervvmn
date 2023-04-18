import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../Controllers/content/survey/survey_creation.dart';
import 'creation_general.dart';

class SurveyCreation extends StatefulWidget {
  const SurveyCreation({super.key});

  @override
  State<SurveyCreation> createState() => _SurveyCreationState();
}

class _SurveyCreationState extends State<SurveyCreation> {
  var surveyCreationController = Get.find<CreationCont>();

  var argu = Get.arguments as SCargubody;
  @override
  void initState() {
    super.initState();
    surveyCreationController.surveyCreationPageController =
        PageController(initialPage: argu.initialPage!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView.builder(
          controller: surveyCreationController.surveyCreationPageController,
          itemCount: 3,
          itemBuilder: (c, i) {
            return SurveyCreationPageUnit(
              indx: i,
              route: argu.fromRoute!,
            );
          }),
    ));
  }
}

class SurveyCreationPageUnit extends StatefulWidget {
  const SurveyCreationPageUnit(
      {Key? key, required this.indx, required this.route})
      : super(key: key);
  final int indx;
  final String route;
  @override
  State<SurveyCreationPageUnit> createState() => _SurveyCreationPageUnitState();
}

class _SurveyCreationPageUnitState extends State<SurveyCreationPageUnit> {
  // var surveyCreationController = Get.find<CreationCont>();
  Widget categorizing(int i) {
    switch (i) {
      case 0:
        return SurveyCreationGeneral(
          route: widget.route,
        );
      // case 1:
      //   return const SurveyCreationQuestion();
      // case 2:
      //   return const SurveyInfoCheck();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          categorizing(widget.indx),
          Center(
            //huudsiin 2 talaar chimeglel baidlaar oruulsan tsenher container
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.indx != 0
                    ? Container(
                        width: Sizes.width * .01,
                        height: Sizes.height * .8,
                        decoration: BoxDecoration(
                            color: Mcolors.geregeBlue,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10))),
                      )
                    : const SizedBox(),
                widget.indx != 3
                    ? Container(
                        width: Sizes.width * .01,
                        height: Sizes.height * .8,
                        decoration: BoxDecoration(
                            color: Mcolors.geregeBlue,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(0))),
                      )
                    : const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
