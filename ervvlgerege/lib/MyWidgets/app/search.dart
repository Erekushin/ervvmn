import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../global_constants.dart';
import '../fundamental/text_heading.dart';

Widget search(TextEditingController cont) {
  return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      width: Sizes.width * .9,
      height: Sizes.height * .07,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 243, 243, 243),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Sizes.width / 10 * 5,
            child: TextField(
              onChanged: (value) {},
              controller: cont,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4),
                labelText: 'Хайх . . .',
                hintText: 'Хайх . . .',
              ),
            ),
          ),
          const InkWell(
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 15,
            ),
          ),
        ],
      ));
}
