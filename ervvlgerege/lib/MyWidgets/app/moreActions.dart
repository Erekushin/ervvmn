import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../fundamental/text_heading.dart';

class MoreActions extends StatefulWidget {
  const MoreActions({Key? key, required this.func}) : super(key: key);
  final Function func;
  @override
  State<MoreActions> createState() => _MoreActionsState();
}

class _MoreActionsState extends State<MoreActions> {
  var proCont = Get.find<ProC>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    widget.func();
                  },
                  icon: const Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.grey,
                  )),
              morebtn('Хувийн мэдээлэл', () {
                Get.toNamed(RouteUnits.generalInfo);
              }),
              morebtn('Холбоосууд', () {}),
              morebtn('Холбоотой асуумжууд', () {}),
              morebtn('Хадагласан контентууд', () {}),
              morebtn('Мэргэжилтэний тохиргоо', () {
                Get.toNamed(RouteUnits.specialistSetting);
              }),
              morebtn('Бот асуумж', () {}),
              morebtn('Грүп үүсгэх', () {}),
              morebtn('Миний үйлчилгээ', () {
                proCont.getMyServices();
                Get.toNamed(RouteUnits.myServices);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget morebtn(String title, Function func) {
    return InkWell(
        onTap: () {
          func();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(margin: const EdgeInsets.all(15), child: txtForm4(title)),
            const Divider(
              thickness: 2,
            )
          ],
        ));
  }
}
