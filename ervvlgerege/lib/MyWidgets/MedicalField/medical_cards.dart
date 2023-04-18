import 'package:flutter/material.dart';

import '../../global_constants.dart';
import '../fundamental/text_heading.dart';
import 'medical_card.dart';

Widget medicalCards(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
          margin: const EdgeInsets.only(top: 15, bottom: 5),
          width: Sizes.width * .85,
          child: headerTxtForm2(title)),
      SizedBox(
        width: Sizes.width,
        height: Sizes.height / 9.93,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (c, i) {
              return InkWell(onTap: () {}, child: const MedicalCard());
            }),
      )
    ],
  );
}
