import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';

import '../Social/user_profile.dart';
import '../fundamental/text_heading.dart';

Widget userSearchComponent() {
  return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.grey.withOpacity(.1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        userProPic(
            'https://i.pinimg.com/564x/33/14/7b/33147b4174a45ec17d9b2f783566cdb8.jpg',
            25),
        const SizedBox(
          width: 5,
        ),
        headerTxtForm6('C.Төгөлдөр'),
        const Spacer(),
        txtGeneral('эмч', 16, 1, FontWeight.normal, Mcolors.deepGreen),
        const SizedBox(
          width: 10,
        )
      ],
    ),
  );
}
