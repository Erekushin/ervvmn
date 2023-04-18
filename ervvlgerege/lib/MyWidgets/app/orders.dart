import 'package:flutter/material.dart';

import '../../global_constants.dart';
import '../fundamental/text_heading.dart';

Widget orders() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 30,
      ),
      headerTxtForm2('Миний товолсон цагууд'),
      SizedBox(
        width: Sizes.width * .9,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (c, i) {
              return Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(5),
                width: Sizes.width * .9,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5))
                    ]),
                child: Center(
                  child: txtForm1(
                      'видео дуудлагаар зөвөлгөө авах цаг 2022/10/04 - 15:30. Эмч Сувдаа(нүд)  үлдсэн хугацаа 1өдөр 3цаг 38минут'),
                ),
              );
            }),
      )
    ],
  );
}
