import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../fundamental/m_icons.dart';
import '../../fundamental/text_heading.dart';

class AppbarChat extends StatefulWidget implements PreferredSizeWidget {
  const AppbarChat(
      {Key? key,
      required this.title,
      required this.callAction,
      required this.videoCallAction,
      required this.backAction,
      required this.color})
      : super(key: key);
  final String title;
  final VoidCallback callAction;
  final VoidCallback videoCallAction;
  final VoidCallback backAction;
  final Color color;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<AppbarChat> createState() => _AppbarChatState();
}

class _AppbarChatState extends State<AppbarChat> {
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
            Row(
              children: [
                InkWell(
                    onTap: () {
                      widget.backAction();
                      Get.back();
                    },
                    child: icon1(FontAwesomeIcons.chevronLeft)),
                const SizedBox(
                  width: 30,
                )
              ],
            ),
            headerTxtForm3(widget.title),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    widget.callAction();
                  },
                  child: icon1(FontAwesomeIcons.phone),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    widget.videoCallAction();
                  },
                  child: icon1(FontAwesomeIcons.video),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
