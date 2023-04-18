import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../MyWidgets/app/app_bar/appbar_square.dart';
import '../../MyWidgets/app/sidebar.dart';
import '../../MyWidgets/fundamental/text_heading.dart';

class TaskCalendarBig extends StatefulWidget {
  const TaskCalendarBig({Key? key}) : super(key: key);

  @override
  State<TaskCalendarBig> createState() => _TaskCalendarBigState();
}

class _TaskCalendarBigState extends State<TaskCalendarBig> {
  GlobalKey<ScaffoldState> menuSidebarKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: menuSidebarKey,
        endDrawer: SidebarGeneral(
          menuAction: () {
            menuSidebarKey.currentState?.closeEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.chat);
          },
        ),
        appBar: AppbarSquare(
          color: Mcolors.geregeBlue,
          title: 'Todo',
          backAction: () {},
          menuAction: () {
            menuSidebarKey.currentState!.openEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
          },
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 40, left: 30, right: 30),
              height: Sizes.height * .4,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0),
                  color: Mcolors.geregeBlue,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: SfCalendar(
                onTap: (chosenDate) {},
                monthViewSettings: MonthViewSettings(
                  monthCellStyle: MonthCellStyle(
                      textStyle: GoogleFonts.sourceSansPro(
                          height: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                      leadingDatesTextStyle: const TextStyle(
                          fontFamily: 'SyneTactile', color: Colors.grey),
                      trailingDatesTextStyle: const TextStyle(
                          fontFamily: 'SyneTactile', color: Colors.grey)),
                ),
                headerStyle: CalendarHeaderStyle(
                    //header
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.sourceSansPro(
                        height: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white)),
                viewHeaderStyle: const ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                      //doloo honogiin vsegnvvd
                      fontFamily: 'SyneTactile',
                      color: Colors.grey),
                ),
                todayTextStyle: GoogleFonts.sourceSansPro(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
                blackoutDatesTextStyle: TextStyle(color: Mcolors.medicalGreen),
                headerDateFormat: 'MMMM',
                view: CalendarView.month,
                initialDisplayDate: DateTime.now(),
                cellBorderColor: Colors.transparent,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: Sizes.height * .40,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (c, i) {
                    return task();
                  }),
            )
          ],
        ));
  }

  Widget task() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 5),
                blurRadius: 10)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [txtForm1('Дорж'), txtForm1('video call')],
          ),
          txtForm17('5000 төг'),
          Column(
            children: [
              txtForm1('on coming'),
              txtForm1('2022-3-15'),
              txtForm1('60 days left'),
            ],
          )
        ],
      ),
    );
  }
}
