import 'package:flutter/material.dart';
import '../../Controllers/image.dart';
import '../../global_constants.dart';
import '../Social/user_profile.dart';
import '../fundamental/text_heading.dart';

class MedicalCard extends StatefulWidget {
  const MedicalCard({Key? key}) : super(key: key);

  @override
  State<MedicalCard> createState() => _MedicalCardState();
}

class _MedicalCardState extends State<MedicalCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5))
              ]),
          padding: const EdgeInsets.all(10),
          width: Sizes.width * .4,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  userProPic(
                    'https://i.pinimg.com/564x/7c/2f/47/7c2f478de45b85fa9b49c220a8e28f7e.jpg',
                    10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txtForm2('Хариуцагч эмч'),
                      const Text(
                        'Билгүүн',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      headerTxtForm2('Дотор'),
                      const Text(
                        'идвэхтэй',
                        style: TextStyle(color: Colors.green, fontSize: 8),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
