import 'package:ervvlgerege/Models/survey.dart';
import 'package:ervvlgerege/MyWidgets/fundamental/buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../global_constants.dart';
import '../app/parts.dart';
import '../fundamental/text_heading.dart';

Widget spacialistRagistration(String questiontitle, List<Options> optionList,
    Function func, Function ref, String type, bool isLast, String pdfName) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      questionTitle(questiontitle),
      SizedBox(
        width: Sizes.width * .9,
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: optionList.length,
                itemBuilder: (c, i) {
                  String option = optionList[i].optionName!;
                  switch (type) {
                    case 'options':
                      return InkWell(
                        onTap: () {
                          func();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: txtForm12(option)),
                            Container(
                              color: Colors.grey,
                              width: Sizes.width * .9,
                              height: 1,
                            )
                          ],
                        ),
                      );
                    case 'pdf':
                      return Container(
                        margin: const EdgeInsets.all(20),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            txtForm16(option),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: (pdfName != '') ? true : false,
                              child: Row(
                                children: [
                                  txtForm16(pdfName),
                                  const Icon(FontAwesomeIcons.check)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                    visible: (pdfName != '') ? true : false,
                                    child: generalBtn(
                                        Mcolors.geregeBlue, 'харах', () {})),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                    visible: (pdfName != '') ? true : false,
                                    child: generalBtn(
                                        Mcolors.geregeBlue, 'устгах', () {})),
                                const SizedBox(
                                  height: 10,
                                ),
                                generalBtn(
                                  Mcolors.geregeBlue,
                                  'сонгох',
                                  () async {
                                    func();
                                    ref();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    default:
                      return SizedBox(
                        child: txtForm16('бүртгэгдээгүй төрөл'),
                      );
                  }
                }),
            Visibility(
              visible: isLast,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  generalBtn(Mcolors.geregeBlue, 'хадаглах', () {
                    //status nemeh hvselt ilgeeh
                    Get.toNamed(RouteUnits.specialistSetting);
                  }),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
}
