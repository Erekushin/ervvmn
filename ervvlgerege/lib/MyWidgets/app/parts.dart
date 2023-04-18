import 'package:flutter/material.dart';

import '../../global_constants.dart';
import '../fundamental/text_heading.dart';

Widget questionTitle(String title) {
  return Column(
    children: [
      const SizedBox(
        height: 50,
      ),
      txtForm12(title),
      Container(
        color: Mcolors.geregeBlue,
        width: Sizes.width * .9,
        height: 1,
      )
    ],
  );
}
