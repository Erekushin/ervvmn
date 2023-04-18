import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../fundamental/m_icons.dart';
import '../../fundamental/text_heading.dart';

class AppbarPdf extends StatefulWidget implements PreferredSizeWidget {
  const AppbarPdf({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<AppbarPdf> createState() => _AppbarSimpleState();
}

class _AppbarSimpleState extends State<AppbarPdf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: Sizes.height * .1,
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: icon1(FontAwesomeIcons.chevronLeft)),
            SizedBox(
              width: 50,
              height: 50,
              child: headerTxtForm3(widget.title),
            ),
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.folder_open,
                color: Colors.black,
                size: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
