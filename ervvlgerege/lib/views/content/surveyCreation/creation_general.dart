import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/content/survey/survey_creation.dart';
import '../../../Helpers/scroll_behavior.dart';
import '../../../Models/content/content_creation.type.dart';
import '../../../MyWidgets/fundamental/text_heading.dart';

class SurveyCreationGeneral extends StatefulWidget {
  const SurveyCreationGeneral({Key? key, required this.route})
      : super(key: key);
  final String route;
  @override
  State<SurveyCreationGeneral> createState() => _SurveyCreationGeneralState();
}

class _SurveyCreationGeneralState extends State<SurveyCreationGeneral> {
  var sCCont = Get.find<CreationCont>();
  List<DropdownMenuItem<String>> dropitems(
      List<ContentCreationTypes> itemlist, String key) {
    return itemlist.map((item) {
      return DropdownMenuItem(
        value: item.typeName.toString(),
        child: Text(item.typeName!),
        onTap: () {
          switch (key) {
            // case 'surveyType':
            //   sCCont.surveyCreationbody.surveyType = item.typeId;
            //   break;
            // case 'countType':
            //   sCCont.surveyCreationbody.countType = item.typeId;
            //   break;
          }
        },
      );
    }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.route) {
      case "/profile":
        // sCCont.surveyNametxtCont.text =
        //     sCont.ownSurveyListbody.value.result![sCont.chosenSurveyIndx].name!;
        break;
      case "/home":
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var sCCont = Get.find<CreationCont>();
    return WillPopScope(
      onWillPop: () async {
        // sCCont.slevel = 1;
        return true;
      },
      child: SafeArea(
          child: Container(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 120, bottom: 10),
        child: ScrollConfiguration(
          behavior: ScrollBehave(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Судалгаа үүсгэх',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  // ner oruulah
                  controller: sCCont.surveyNametxtCont,
                  decoration: const InputDecoration(
                      hintText: 'Судалгааны нэрийг оруулах'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  // toonii torol songoh
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    txtForm11('Судалгааны тоо'),
                    DropdownButton<String>(
                        hint: txtForm11('Судалгааны тоо'),
                        value: sCCont.counttypeStr,
                        onChanged: (String? newValue) {
                          setState(() {
                            sCCont.counttypeStr = newValue.toString();
                          });
                          switch (newValue) {
                            case 'хязгаартай':
                              sCCont.limitCountVis.value = true;
                              break;
                            case 'хязгааргүй':
                              sCCont.limitCountVis.value = false;
                              break;
                          }
                        },
                        underline: const SizedBox(),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(5),
                        items: dropitems(
                            sCCont.surveyCreationTypes.result!.countType ?? [],
                            'countType')),
                    Visibility(
                        visible: sCCont.limitCountVis.value,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: sCCont.surveyInputLimitation,
                          decoration: const InputDecoration(
                              hintText:
                                  'Судалгааг хэдэн удаа бөглөх боломтой вэ?'),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  // torol songoh
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    txtForm11('Судалгааны төрөл'),
                    DropdownButton<String>(
                        hint: txtForm11('Судалгааны төрөл'),
                        value: sCCont.torolStr,
                        onChanged: (String? newValue) {
                          setState(() {
                            sCCont.torolStr = newValue.toString();
                          });
                          // switch (newValue) {
                          //   case 'Auto':
                          //     sCCont.sSwitcher.value = true;
                          //     break;
                          //   case 'энгийн':
                          //     sCCont.sSwitcher.value = false;
                          //     break;
                          // }
                        },
                        underline: const SizedBox(),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(5),
                        items: dropitems(
                            sCCont.surveyCreationTypes.result!.surveyType ?? [],
                            'surveyType')),
                    // Visibility(
                    //     visible: sCCont.sSwitcher.value,
                    //     child: Text(sCCont.slevel.toString()))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
