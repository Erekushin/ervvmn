// ignore: file_names
import 'package:flutter/material.dart';
import '../../global_constants.dart';
import '../fundamental/buttons.dart';
import '../fundamental/text_heading.dart';

Widget notSomething(Color btnColor, String btnTitle, String imgUrl,
    String hintTxt, Function func) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.all(10),
        width: Sizes.width * .9,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage(imgUrl), fit: BoxFit.contain)),
      ),
      Container(
        margin: const EdgeInsets.all(20),
        child: txtForm15(hintTxt),
      ),
      Center(
        child: InkWell(
            child: SizedBox(
                width: 300,
                child: generalBtn(btnColor, btnTitle, () {
                  func();
                }))),
      )
    ],
  );
}

Widget notSomethingMini(Color btnColor, String btnTitle, String imgUrl,
    String hintTxt, Function func) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.all(10),
        width: Sizes.width * .5,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage(imgUrl), fit: BoxFit.contain)),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            margin: const EdgeInsets.all(5),
            child: txtForm11(hintTxt),
          ),
          Center(
            child: InkWell(
                child: SizedBox(
                    width: 150,
                    child: generalBtn(btnColor, btnTitle, () {
                      func();
                    }))),
          )
        ],
      )
    ],
  );
}
