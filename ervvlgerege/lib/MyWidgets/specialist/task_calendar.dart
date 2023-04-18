import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';

class TaskCalendar extends StatefulWidget {
  const TaskCalendar({Key? key}) : super(key: key);

  @override
  State<TaskCalendar> createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  List<EachDay> nextTenDays = [];
  DateTime currentTime = DateTime.now();

  late DateTime nextDay;
  bool monthIsthere = false;
  double month1 = 50;
  double month2 = 50;
  @override
  void initState() {
    super.initState();
    nextTenDays.add(EachDay(
        month: currentTime.month, day: currentTime.day, isbooked: false));
    for (int a = 1; a < 10; a++) {
      nextDay = currentTime.add(Duration(days: a));
      if (nextDay.month != nextTenDays.last.month) {
        int a = nextTenDays.lastIndexOf(nextTenDays.last) + 1;
        month1 = (Sizes.width / 17.83 + 4) * a;
        if (a == 9) {
          month2 = Sizes.width / 17.83;
        } else if (a == 1) {
          month1 = Sizes.width / 17.83;
        }
      }
      nextTenDays.add(
          EachDay(month: nextDay.month, day: nextDay.day, isbooked: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 13),
        width: Sizes.width / 1.49,
        height: Sizes.width / 17.83 + 15,
        child: Column(
          children: [
            SizedBox(
              width: Sizes.width / 1.49,
              height: Sizes.width / 17.83,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: nextTenDays.length,
                itemBuilder: (c, i) {
                  var day = nextTenDays[i];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey.withOpacity(.5),
                    ),
                    margin: const EdgeInsets.only(right: 4),
                    width: Sizes.width / 17.83,
                    height: Sizes.width / 17.83,
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: Sizes.width / 1.49,
              height: 15,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: nextTenDays.length,
                  itemBuilder: (c, i) {
                    var day = nextTenDays[i];
                    if (i != 0) {
                      monthIsthere = true;
                      if (day.month != nextTenDays[i - 1].month) {
                        monthIsthere = false;
                      }
                    }
                    return monthIsthere
                        ? const SizedBox()
                        : SizedBox(
                            width: i == 0 ? month1 : month2,
                            child: Text(
                              '${day.month}-р сар',
                              style: const TextStyle(fontSize: 11),
                              maxLines: 2,
                            ),
                          );
                  }),
            )
          ],
        ));
  }
}

class EachDay {
  int? month;
  int? day;
  bool? isbooked;
  EachDay({required this.month, required this.day, required this.isbooked});
}
