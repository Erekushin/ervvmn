import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget txtField1(String hinttxt, TextEditingController cont) {
  return TextField(
    controller: cont,
    style: GoogleFonts.sourceSansPro(
        height: 1,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.black54),
    decoration: InputDecoration(
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(4),
      hintText: hinttxt,
    ),
  );
}

Widget txtFieldPass(String hinttxt, TextEditingController cont) {
  return TextField(
    obscureText: true,
    controller: cont,
    style: GoogleFonts.sourceSansPro(
        height: 1,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.black54),
    decoration: InputDecoration(
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(4),
      hintText: hinttxt,
    ),
  );
}

Widget txtField2(TextEditingController txtCont, String hinttxt, Function func) {
  return Container(
    padding: const EdgeInsets.only(
      left: 15,
    ),
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.15),
        borderRadius: const BorderRadius.all(Radius.circular(15))),
    child: TextField(
      onChanged: (value) {
        func();
      },
      controller: txtCont,
      style: GoogleFonts.sourceSansPro(
          height: 2,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Colors.black54),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          FontAwesomeIcons.pen,
          color: Colors.grey,
          size: 15,
        ),
        hintStyle: const TextStyle(color: Colors.black54),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(4),
        hintText: hinttxt,
      ),
    ),
  );
}

Widget richTxt(TextEditingController txtCont, String hinttxt) {
  return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.grey.withOpacity(.15),
      ),
      child: Stack(
        children: [
          TextFormField(
            controller: txtCont,
            style: GoogleFonts.sourceSansPro(
                height: 1,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black54),
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.black54),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(4),
              hintText: hinttxt,
            ),
            minLines: 3,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Icon(
              FontAwesomeIcons.pen,
              color: Colors.grey,
              size: 15,
            ),
          ),
        ],
      ));
}
