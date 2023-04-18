import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';

import '../fundamental/progress.dart';
import '../fundamental/text_heading.dart';

class DailyInput extends StatefulWidget {
  const DailyInput({Key? key}) : super(key: key);

  @override
  State<DailyInput> createState() => _DailyInputState();
}

class _DailyInputState extends State<DailyInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      width: Sizes.width * .9,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [txtForm2('Алхалт'), headerTxtForm1('200/4000')],
          ),
          const MyProgress()
        ],
      ),
    );
  }
}
