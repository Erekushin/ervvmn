import 'package:flutter/material.dart';

import '../../../MyWidgets/app/app_bar/appbar_simple.dart';
import '../../../MyWidgets/app/widget_combo.dart';
import '../../../MyWidgets/fundamental/buttons.dart';
import '../../../global_constants.dart';

class HealthInfo extends StatefulWidget {
  const HealthInfo({Key? key}) : super(key: key);

  @override
  State<HealthInfo> createState() => _HealthInfoState();
}

class _HealthInfoState extends State<HealthInfo> {
  TextEditingController txt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSimple(
        title: 'Эрүүл мэндийн мэдээлэл',
        backAction: () {},
        color: const Color(0xff464646),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              input('Өндөр (см)', '95258154', txt),
              input('Жин (кг)', 'svhee@gmail.com', txt),
              input('Биеийн жингийн индекс', '**********', txt),
              input('Цусны бүлэг', 'ак00445566', txt),
              const SizedBox(height: 10),
              greenInfoBtn('Архаг хууч өвчиний судалгаа', () {}),
              const SizedBox(height: 20),
              greenInfoBtn('Хооллолтын судалгаа', () {}),
              const SizedBox(height: 20),
              greenInfoBtn('Харшилын судалгаа', () {}),
              const SizedBox(height: 20),
              greenInfoBtn('Эмчилгээний картууд', () {}),
              SizedBox(
                width: Sizes.width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [generalBtn(Mcolors.geregeBlue, 'хадаглах', () {})],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
