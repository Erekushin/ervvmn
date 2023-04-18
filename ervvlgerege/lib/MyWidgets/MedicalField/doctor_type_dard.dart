import 'package:flutter/material.dart';

import '../fundamental/text_heading.dart';

Widget doctorTypeCard(final image, String title) {
  return InkWell(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.black45)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          Container(
              color: const Color(0xFFF0F0F0),
              width: 130,
              height: 80,
              child: Image.asset(image)),
          Container(
            margin: const EdgeInsets.all(5),
            child: txtForm9(title),
          )
        ],
      ),
    ),
  );
}
