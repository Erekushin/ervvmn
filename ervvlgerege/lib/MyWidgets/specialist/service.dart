// ignore: file_names
import 'package:flutter/material.dart';

import '../../global_constants.dart';
import '../Social/user_profile.dart';
import '../fundamental/text_heading.dart';

Widget serviceOfSpecialist(Function func) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 30,
      ),
      headerTxtForm2('Үйлчилгээнүүд'),
      SizedBox(
        width: Sizes.width * .9,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (c, i) {
              return InkWell(
                onTap: () {
                  func();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(10),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      userProPic(
                          'https://i.pinimg.com/564x/33/14/7b/33147b4174a45ec17d9b2f783566cdb8.jpg',
                          25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          headerTxtForm6('зүрх судас эмчилгээ'),
                          const SizedBox(height: 15),
                          headerTxtForm6('115000 төг (tele)')
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      )
    ],
  );
}
