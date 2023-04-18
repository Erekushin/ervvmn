import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../MyWidgets/app/app_bar/appbar_simple.dart';
import '../../../MyWidgets/specialist/specialist_registration.dart';
import '../../../global_constants.dart';

class SpecialistRegistration extends StatefulWidget {
  const SpecialistRegistration({Key? key}) : super(key: key);

  @override
  State<SpecialistRegistration> createState() => _SpecialistRegistrationState();
}

class _SpecialistRegistrationState extends State<SpecialistRegistration> {
  int index = 0;
  String pdfName = '';
  var proCont = Get.find<ProC>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSimple(
        title: 'Мэргэжилтэний тохиргоо',
        backAction: () {},
        color: const Color(0xff464646),
      ),
      body: Center(
        child: spacialistRagistration(
            proCont.survey.questions![index].quistion!,
            proCont.survey.questions![index].options!, () {
          setState(() {
            if (index < proCont.survey.questions!.length - 1) {
              index++;
            }
          });
        }, () async {
          String a = await GlobalHelpers.workingWithFile.pickFile() ?? '';
          setState(() {
            pdfName = a;
          });
        }, proCont.survey.questions![index].type!,
            index == proCont.survey.questions!.length - 1, pdfName),
      ),
    );
  }
}
