import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../fundamental/m_icons.dart';
import '../../fundamental/text_heading.dart';

// ignore: must_be_immutable
class AppbarSquare extends StatefulWidget implements PreferredSizeWidget {
  AppbarSquare(
      {Key? key,
      required this.title,
      required this.backAction,
      required this.menuAction,
      required this.color})
      : super(key: key);
  String title;
  VoidCallback backAction;
  final VoidCallback menuAction;
  Color color;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<AppbarSquare> createState() => _AppbarSquareState();
}

class _AppbarSquareState extends State<AppbarSquare> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderOnForeground: false,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: Sizes.height * .1,
        decoration: BoxDecoration(
            color: widget.color,
            border: Border.all(color: Mcolors.geregeBlue, width: 0)),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    widget.backAction();
                    Get.back();
                  },
                  child: icon1(FontAwesomeIcons.chevronLeft)),
              headerTxtForm3(widget.title),
              InkWell(
                onTap: () {
                  widget.menuAction();
                },
                child: icon1(FontAwesomeIcons.bars),
              )
            ],
          ),
        ),
      ),
    );
  }
}
