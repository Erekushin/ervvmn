import 'package:flutter/material.dart';

class MyProgress extends StatefulWidget {
  const MyProgress({Key? key}) : super(key: key);

  @override
  State<MyProgress> createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(45))),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      height: 18,
      child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff3FDA6A),
                      Color(0xff018926),
                    ]),
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(45))),
            width: 100,
            height: 18,
          )),
    );
  }
}
