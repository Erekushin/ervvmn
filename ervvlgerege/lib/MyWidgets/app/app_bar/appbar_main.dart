import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../fundamental/m_icons.dart';
import '../../fundamental/text_heading.dart';

class AppbarMain extends StatefulWidget implements PreferredSizeWidget {
  const AppbarMain(
      {Key? key,
      required this.title,
      required this.menuAction,
      required this.backAction,
      required this.color})
      : super(key: key);
  final String title;
  final VoidCallback menuAction;
  final VoidCallback backAction;
  final Color color;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<AppbarMain> createState() => _AppbarMainState();
}

class _AppbarMainState extends State<AppbarMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: Sizes.height * .1,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
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
              borderRadius: BorderRadius.circular(15),
              splashColor: Colors.grey.withOpacity(0.01),
              onTap: () {
                widget.menuAction();
              },
              child: icon1(FontAwesomeIcons.bars),
            )
          ],
        ),
      ),
    );
  }
}
