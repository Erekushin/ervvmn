import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:flutter/material.dart';

import '../../../MyWidgets/app/app_bar/appbar_simple.dart';
import '../../../MyWidgets/app/parts.dart';
import '../../../MyWidgets/app/widget_combo.dart';
import '../../../MyWidgets/fundamental/buttons.dart';
import '../../../MyWidgets/fundamental/text_heading.dart';
import '../../../MyWidgets/specialist/notSomething.dart';
import '../../../global_constants.dart';
import 'package:get/get.dart';

class SpecialistInfo extends StatefulWidget {
  const SpecialistInfo({Key? key}) : super(key: key);

  @override
  State<SpecialistInfo> createState() => _SpecialistInfoState();
}

class _SpecialistInfoState extends State<SpecialistInfo> {
  var proCont = Get.find<ProC>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppbarSimple(
          title: 'Мэргэжилтэний тохиргоо',
          backAction: () {},
          color: const Color(0xff464646),
        ),
        body: GetX<ProC>(builder: (cont) {
          return (cont.isSpecialist.value)
              ? specialist()
              : notSomething(
                  Mcolors.geregeBlue,
                  'мэргэжилтэн болох',
                  'assets/images/rangers.jpg',
                  'Та мэргэжилтэн болоогүй байна. Уг тохиргоог идвэхжүүлсэнээр та өөрийн гэсэн үйлчилгээнүүдийг олон нийтэд санал болгон нэмэлт орлого олох боломжтой юм',
                  () {
                  proCont.getSurvey();
                  Get.toNamed(RouteUnits.specialistRegistration);
                });
        }));
  }

  Widget specialist() {
    var proCont = Get.find<ProC>();
    var txt = TextEditingController();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            questionTitle('Эмч'),
            const SizedBox(
              height: 10,
            ),
            input('Боловсрол', 'дээд', txt),
            const SizedBox(
              height: 10,
            ),
            input('Чиглэл', 'дотор', txt),
            const SizedBox(
              height: 10,
            ),
            input('Ажилын туршлага', '8 аас дээш жил', txt),
            const SizedBox(
              height: 10,
            ),
            certificateCombo(),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Mcolors.geregeBlue,
              width: Sizes.width * .9,
              height: 1,
            ),
            SizedBox(
              width: Sizes.width * .9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  generalBtn(Mcolors.geregeBlue, 'статус нэмэх', () {
                    proCont.getSurvey();
                    Get.toNamed(RouteUnits.specialistRegistration);
                  })
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: Sizes.width * .5,
              height: 150,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/rangers.jpg'),
                      fit: BoxFit.contain)),
            ),
            txtForm15(
                'Та статус нэмэх замаар өөрийн өөр бусад чадварыг ашиглан бусдад үйлчилгээ үзүүлж нэмэлт орлого олох боломжтой'),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
