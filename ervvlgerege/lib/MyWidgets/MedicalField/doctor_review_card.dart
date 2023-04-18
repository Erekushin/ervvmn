import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../global_constants.dart';
import '../Social/user_profile.dart';
import '../fundamental/text_heading.dart';

Widget doctorReviewCard() {
  return Container(
    margin: const EdgeInsets.all(10),
    width: Sizes.width * .7,
    height: Sizes.height * .17,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.black45)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: userProPic(
                    'https://i.pinimg.com/564x/7c/2f/47/7c2f478de45b85fa9b49c220a8e28f7e.jpg',
                    30),
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  txtForm4('С.Төгөлдөр'),
                  txtForm4('Дотор-Ходоод элэг цөс'),
                  txtForm4('Ажлын туршлага'),
                  const SizedBox(
                    height: 10,
                  ),
                  txtForm9('Үнэлгээ : 3.5'),
                ],
              ),
            )
          ],
        ),
        Container(
          width: 200,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Mcolors.medicalGreen),
        )
      ],
    ),
  );
}
