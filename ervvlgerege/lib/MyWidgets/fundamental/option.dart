import 'package:ervvlgerege/MyWidgets/fundamental/text_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/entrance.dart';

class OptionsVertical extends StatefulWidget {
  OptionsVertical({Key? key, required this.valueList, required this.selected})
      : super(key: key);
  final valueList;
  String selected;
  @override
  State<OptionsVertical> createState() => _OptionsVerticalState();
}

class _OptionsVerticalState extends State<OptionsVertical> {
  @override
  Widget build(BuildContext context) {
    String a = widget.selected;
    return Column(
      children: widget.valueList.map<Widget>((value) {
        final selected = a == value;
        final color = selected ? Colors.green : Colors.grey;
        return SizedBox(
          width: 100,
          height: 50,
          child: InkWell(
            onTap: () {
              setState(() {
                widget.selected = value;
              });
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 15,
                  height: 15,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                ),
                Text(value)
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class OptionsHorizontal extends StatefulWidget {
  OptionsHorizontal(
      {Key? key,
      required this.valueList,
      required this.selected,
      required this.func})
      : super(key: key);
  final valueList;
  String selected;
  Function func;
  @override
  State<OptionsHorizontal> createState() => _OptionsHorizontalState();
}

class _OptionsHorizontalState extends State<OptionsHorizontal> {
  var authCont = Get.find<AuthC>();
  @override
  Widget build(BuildContext context) {
    String a = widget.selected;
    return Wrap(
      children: widget.valueList.map<Widget>((value) {
        final selected = a == value;
        final color = selected ? Colors.green : Colors.grey;
        return SizedBox(
          width: 90,
          height: 50,
          child: InkWell(
            onTap: () {
              widget.selected = value;
              widget.func(value);
              setState(() {});
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 15,
                  height: 15,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                ),
                txtForm5(value)
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
