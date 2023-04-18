import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../fundamental/text_heading.dart';

Future<bool> cloaseTheApp() async {
  return await Get.defaultDialog(
      title: '',
      content: txtForm12('Апп-ыг хаах уу?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: headerTxtForm4('хаах'),
        ),
      ]);
}
