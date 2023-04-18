import 'package:ervvlgerege/Controllers/entrance.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../MyWidgets/app/app_bar/appbar_simple.dart';
import '../../MyWidgets/fundamental/my_switcher.dart';
import '../../MyWidgets/fundamental/text_heading.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var auth = Get.find<AuthC>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSimple(
        title: 'Тохиргоо',
        backAction: () {},
        color: Mcolors.geregeBlue,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              settingUnit('Хурууны хээн нэвтрэлт', () {
                if (GlobalHelpers.ifFingering == false) {
                  GlobalHelpers.workingWithFile
                      .addNewItem('isFingering', 'true');
                  GlobalHelpers.workingWithFile
                      .addNewItem('name', auth.loginname.text);
                  GlobalHelpers.workingWithFile
                      .addNewItem('pass', auth.passWord.text);
                } else if (GlobalHelpers.pass != '') {
                  GlobalHelpers.workingWithFile.deleteAll();
                }
              }, true, GlobalHelpers.ifFingering),
              settingUnit('Нууц үг солих', () {}, false, false),
              settingUnit('Гүйлгээний нууц үг солих', () {}, false, false)
            ],
          ),
        ),
      ),
    );
  }

  Widget settingUnit(
      String title, Function func, bool isSwitcher, bool isSwitcherActivated) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.black45, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          txtForm15(title),
          isSwitcher
              ? MySwitcher(
                  keyWord: 'setting',
                  switcherValue: isSwitcherActivated,
                  func: () {
                    func();
                  },
                )
              : const Icon(
                  FontAwesomeIcons.rightLong,
                  size: 12,
                )
        ],
      ),
    );
  }
}
