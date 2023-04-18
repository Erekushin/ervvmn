import 'package:ervvlgerege/Controllers/entrance.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../fundamental/text_heading.dart';

class SidebarGeneral extends StatefulWidget {
  const SidebarGeneral({Key? key, required this.menuAction}) : super(key: key);
  final Function menuAction;
  @override
  State<SidebarGeneral> createState() => _SidebarGeneralState();
}

class _SidebarGeneralState extends State<SidebarGeneral> {
  var authCont = Get.find<AuthC>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: InkWell(
                onTap: () {
                  widget.menuAction();
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xff0139FF).withOpacity(.15),
                        const Color(0xff8F00FF).withOpacity(.15),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.menuAction();
                        },
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      menuComponent(
                          context, FontAwesomeIcons.magnifyingGlass, 'Хайх',
                          () {
                        Get.toNamed(RouteUnits.search);
                      }),
                      menuComponent(context, FontAwesomeIcons.solidBell,
                          'Мэдэгдэл', () {}),
                      menuComponent(context, FontAwesomeIcons.peopleGroup,
                          'Дагагчид', () {}),
                      menuComponent(context, FontAwesomeIcons.layerGroup,
                          'Миний Грүпүүд', () {}),
                      menuComponent(context, FontAwesomeIcons.gear, 'Тохиргоо',
                          () {
                        Get.toNamed(RouteUnits.setting);
                      }),
                      menuComponent(context, FontAwesomeIcons.book,
                          'апп-ын тухай', () {}),
                      menuComponent(context, FontAwesomeIcons.phone,
                          'Холбоо барих', () {}),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        FontAwesomeIcons.doorOpen,
                        size: 18,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        splashColor: Colors.grey.withOpacity(0.01),
                        onTap: () {
                          authCont.loginname.clear();
                          authCont.passWord.clear();
                          Get.offAllNamed(RouteUnits.login);
                        },
                        child: txtGeneral('Гарах', 16, 1, FontWeight.normal,
                            Colors.grey.shade400),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                const Expanded(child: SizedBox())
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget menuComponent(
      BuildContext context, IconData icon, String txt, Function func) {
    return InkWell(
      onTap: () {
        func();
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.grey.withOpacity(0.01),
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10),
          margin: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade400, width: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: const Color(0xff465C94),
                size: 18,
              ),
              const SizedBox(
                width: 10,
              ),
              headerTxtForm4(txt)
            ],
          ),
        ),
      ),
    );
  }
}
