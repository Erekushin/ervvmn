import 'package:ervvlgerege/MyWidgets/fundamental/text_heading.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget greenInfoBtn(String title, Function func) {
  return InkWell(
    onTap: () {
      func();
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      width: Sizes.width * .9,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Mcolors.medicalGreen),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          txtForm14(title, Colors.white),
          const Icon(
            FontAwesomeIcons.rightLong,
            color: Colors.white,
            size: 15,
          ),
        ],
      ),
    ),
  );
}

Widget generalBtn(Color clr, String title, Function func) {
  return InkWell(
    onTap: () {
      func();
    },
    child: Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)), color: clr),
      child: Center(
        child: txtForm14(title, Colors.white),
      ),
    ),
  );
}

Widget popUpbtn(String title, IconData icon, Function func) {
  return InkWell(
    onTap: () {
      func();
    },
    child: Container(
      width: Sizes.width * .4,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      color: Colors.grey.shade300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerTxtForm6(title),
          Icon(
            icon,
            color: Mcolors.geregeBlue,
          )
        ],
      ),
    ),
  );
}

Widget greyTestBtn(String title, Function func) {
  return InkWell(
    onTap: () {
      func();
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      width: Sizes.width * .9,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          headerTxtForm6(title),
        ],
      ),
    ),
  );
}
