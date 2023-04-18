import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget txtGeneral(String txt, double size,
    [double txtheight = 1,
    FontWeight txtWeight = FontWeight.w400,
    Color color = Colors.black]) {
  return Text(
    txt,
    maxLines: 4,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.sourceSansPro(
        height: txtheight, fontWeight: txtWeight, fontSize: size, color: color),
  );
}

Widget txtCenter(String txt, double size,
    [double txtheight = 1,
    FontWeight txtWeight = FontWeight.w400,
    Color color = Colors.black]) {
  return Text(
    textAlign: TextAlign.center,
    txt,
    maxLines: 5,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.sourceSansPro(
        height: txtheight, fontWeight: txtWeight, fontSize: size, color: color),
  );
}

Widget headerTxtForm1(String txt) {
  return txtGeneral(txt, 12);
}

Widget headerTxtForm2(String txt) {
  return txtGeneral(txt, 12, 1, FontWeight.w600);
}

Widget headerTxtForm3(String txt) {
  //Профайл
  return txtGeneral(txt, 18, 1, FontWeight.bold, Colors.white);
}

Widget headerTxtForm4(String txt) {
  //menu nii txt
  return txtGeneral(txt, 16, 1, FontWeight.bold, const Color(0xff465C94));
}

Widget headerTxtForm5(String txt) {
  //Marea
  return txtGeneral(txt, 25, 1, FontWeight.bold, Colors.white);
}

Widget headerTxtForm6(String txt) {
  //Профайл
  return txtGeneral(txt, 16, 1, FontWeight.normal, Colors.black45);
}

Widget txtForm1(String txt) {
  return txtGeneral(txt, 12, 1, FontWeight.normal, Colors.black54);
}

Widget txtForm2(String txt) {
  //хэтэвч
  return txtGeneral(txt, 11, 1, FontWeight.w300);
}

Widget txtForm3(String txt, double size) {
  return Text(txt,
      maxLines: 3,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.sourceSansPro(
          fontSize: size,
          foreground: Paint()
            ..shader = const LinearGradient(
                    colors: <Color>[Color(0xFF005DEA), Colors.purpleAccent])
                .createShader(const Rect.fromLTWH(80, 10, 150, 10))));
}

Widget txtForm4(String txt) {
  //login words
  //more btns
  return txtCenter(txt, 14, 1, FontWeight.w600, Colors.black54);
}

Widget txtForm5(String txt) {
  //menu nii txt
  return txtGeneral(txt, 15, 1, FontWeight.w600, Colors.black54);
}

Widget txtForm6(String txt) {
  //menu nii txt
  return txtGeneral(txt, 16, 1, FontWeight.w600, Colors.black54);
}

Widget txtTimer(String txt) {
  //menu nii txt
  return txtGeneral(txt, 40, 1, FontWeight.w600, Colors.black54);
}

Widget txtForm7(String txt, int colorSwitcher) {
  //menu nii txt
  return txtCenter(
      txt,
      14,
      1,
      FontWeight.w600,
      colorSwitcher == 1
          ? const Color.fromARGB(255, 48, 153, 51)
          : colorSwitcher == 2
              ? Colors.red
              : Colors.grey);
}

Widget txtForm8(String txt) {
  return txtGeneral(txt, 16, 1, FontWeight.w600, Colors.black54);
}

Widget txtForm9(String txt) {
  return txtGeneral(txt, 12, 1, FontWeight.w700, Colors.black);
}

Widget txtForm10(String txt) {
  return txtGeneral(txt, 11, 1, FontWeight.w700, Colors.white);
}

Widget chattxt(String txt) {
  return txtGeneral(txt, 15, 1, FontWeight.w700, Colors.white);
}

Widget txtForm11(String txt) {
  return txtGeneral(txt, 11, 1, FontWeight.w700, Colors.grey);
}

Widget txtForm12(String txt) {
  return txtCenter(txt, 25, 1, FontWeight.w700, Colors.black45);
}

Widget txtForm13(String txt) {
  return txtGeneral(txt, 11, 1, FontWeight.w700, Mcolors.medicalGreen);
}

Widget txtForm14(String txt, Color color) {
  return txtGeneral(txt, 15, 1, FontWeight.w700, color);
}

Widget txtForm15(String txt) {
  return txtCenter(txt, 16, 1, FontWeight.w700, Colors.black45);
}

Widget txtForm16(String txt) {
  return txtCenter(txt, 12, 1, FontWeight.bold, Colors.black);
}

Widget txtForm17(String txt) {
  return txtGeneral(txt, 22, 1, FontWeight.normal, Colors.black);
}
