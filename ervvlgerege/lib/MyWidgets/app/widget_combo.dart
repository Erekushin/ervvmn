import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../MyWidgets/fundamental/text_heading.dart';
import '../../../MyWidgets/fundamental/txt_field.dart';

Widget input(String title, String hint, TextEditingController txtCont) {
  return Container(
    width: Sizes.width * .9,
    margin: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [headerTxtForm2(title), txtField2(txtCont, hint, () {})],
    ),
  );
}

Widget falseInput(String title, String hint, TextEditingController txtCont,
    Function func, String errorHnt, int hintColor) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerTxtForm2(title),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            width: Sizes.width * .9,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.15),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hint,
                  style: GoogleFonts.sourceSansPro(
                      height: 1,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                const Icon(
                  FontAwesomeIcons.rightLong,
                  color: Colors.grey,
                  size: 15,
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            txtForm7(errorHnt, hintColor),
            const SizedBox(
              width: 20,
            )
          ],
        )
      ],
    ),
  );
}

Widget input2(String title, String hint, TextEditingController txtCont) {
  return Container(
    width: Sizes.width * .9,
    margin: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerTxtForm2(title),
        richTxt(
          txtCont,
          hint,
        ),
      ],
    ),
  );
}

Widget certificateCombo() {
  return SizedBox(
    width: Sizes.width * .9,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerTxtForm2('Бичиг баримт'),
        Container(
          margin: const EdgeInsets.all(10),
          width: Sizes.width * .9,
          height: 300,
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                  image: AssetImage('assets/images/diploma.jpeg'),
                  fit: BoxFit.contain)),
        ),
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.15),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: Sizes.width * .7,
                  child: txtForm16(
                      'Нийслэлийн эрүүл мэндийн газрын тодорхойлолт')),
              const Icon(
                FontAwesomeIcons.pen,
                size: 15,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

class Searchbtns extends StatefulWidget {
  const Searchbtns({super.key});

  @override
  State<Searchbtns> createState() => _SearchbtnsState();
}

class _SearchbtnsState extends State<Searchbtns> {
  bool bvgd = true;
  bool emch = false;
  bool emneleg = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        searchBtn('Бүгд', () {}),
        searchBtn('Эмч', () {}),
        searchBtn('Эмнэлэг', () {}),
      ],
    );
  }

  Widget searchBtn(String title, Function func) {
    Color backColor = Colors.white;
    Color textColor = Colors.grey;
    switch (title) {
      case 'Бүгд':
        if (bvgd == true) {
          backColor = Mcolors.geregeBlue;
          textColor = Colors.white;
        } else {
          backColor = Colors.white;
          textColor = Colors.grey;
        }
        break;
      case 'Эмч':
        if (emch == true) {
          backColor = Mcolors.geregeBlue;
          textColor = Colors.white;
        } else {
          backColor = Colors.white;
          textColor = Colors.grey;
        }
        break;
      case 'Эмнэлэг':
        if (emneleg == true) {
          backColor = Mcolors.geregeBlue;
          textColor = Colors.white;
        } else {
          backColor = Colors.white;
          textColor = Colors.grey;
        }
        break;
    }
    return InkWell(
      onTap: () {
        switch (title) {
          case 'Бүгд':
            bvgd ? bvgd = false : bvgd = true;
            emch = false;
            emneleg = false;
            break;
          case 'Эмч':
            bvgd ? bvgd = false : bvgd = false;
            emch ? emch = false : emch = true;
            break;
          case 'Эмнэлэг':
            bvgd ? bvgd = false : bvgd = false;
            emneleg ? emneleg = false : emneleg = true;
            break;
        }
        setState(() {});
        func();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Mcolors.geregeBlue, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: backColor),
        child: Center(
          child: txtForm14(title, textColor),
        ),
      ),
    );
  }
}
