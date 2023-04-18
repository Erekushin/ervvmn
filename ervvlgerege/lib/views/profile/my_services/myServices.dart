import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:ervvlgerege/MyWidgets/app/app_bar/appbar_simple.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../MyWidgets/fundamental/text_heading.dart';
import '../../../MyWidgets/specialist/notSomething.dart';
import '../../../global_constants.dart';

class MyServices extends StatefulWidget {
  const MyServices({Key? key}) : super(key: key);
  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  var proCont = Get.find<ProC>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (proCont.myServiceB.services!.isEmpty)
          ? const SizedBox()
          : FloatingActionButton(
              backgroundColor: Mcolors.geregeBlue,
              child: const Icon(FontAwesomeIcons.plus),
              onPressed: () {},
            ),
      appBar: AppbarSimple(
        title: 'Миний үйлчилгээнүүд',
        color: const Color(0xff464646),
        backAction: () {},
      ),
      body: (proCont.myServiceB.services!.isEmpty)
          ? notSomething(
              Mcolors.geregeBlue,
              'үйлчилгээ нэмэх',
              'assets/images/rangers.jpg',
              'Та өөрийн чадвар, мэдлэгэ туршлагаа tele үйлчилгээ болгон нийтэд санал болгосоноор нэмэлт орлого олох боломжтой юм',
              () {})
          : myservices(),
    );
  }

  Widget myservices() {
    return ListView.builder(
        itemCount: proCont.myServiceB.services!.length,
        itemBuilder: (c, i) {
          var item = proCont.myServiceB.services![i];
          return InkWell(
            onTap: () {
              Get.toNamed(RouteUnits.myServiceInfo, arguments: i);
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ]),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item.image!),
                            fit: BoxFit.cover),
                        color: Colors.grey,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        txtForm17(item.name!),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            txtForm16('${item.payment} (${item.type})')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
