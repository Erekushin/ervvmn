import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/profile.dart';
import '../../Helpers/logging.dart';

class MySwitcher extends StatefulWidget {
  const MySwitcher(
      {Key? key,
      required this.switcherValue,
      required this.keyWord,
      required this.func})
      : super(key: key);
  final bool switcherValue;
  final String keyWord;
  final Function func;
  @override
  // ignore: library_private_types_in_public_api
  _MySwitcher createState() => _MySwitcher();
}

class _MySwitcher extends State<MySwitcher> with TickerProviderStateMixin {
  final medlog = logger(_MySwitcher);
  final _duration = const Duration(milliseconds: 1);
  late Animation<Alignment> animation;
  late AnimationController _animationController;
  late bool switcherValue;
  var proCont = Get.find<ProC>();
  _onTap() {
    widget.func();
    setState(
      () {
        if (switcherValue) {
          medlog.i('untraah daralt');
          proCont.specialistSwitcher.value = false;
          switcherValue = false;
          _animationController.reverse();
        } else {
          medlog.i('idvehjvvleh daralt');
          proCont.specialistSwitcher.value = true;
          switcherValue = true;
          _animationController.forward();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    switcherValue = widget.switcherValue;
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    animation = AlignmentTween(
            begin: switcherValue ? Alignment.centerRight : Alignment.centerLeft,
            end: switcherValue ? Alignment.centerLeft : Alignment.centerRight)
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        switch (widget.keyWord) {
          case 'specialist':
            return Center(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _onTap();
                },
                child: Container(
                  width: Sizes.width / 8.89,
                  height: Sizes.height / 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: switcherValue
                            ? const AssetImage('assets/images/day4.jpg')
                            : const AssetImage('assets/images/night2.jpg'),
                        fit: BoxFit.fill),
                    color: switcherValue ? Colors.green : Colors.red,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(99),
                    ),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 100),
                    alignment: switcherValue
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: Sizes.height / 84.18,
                      height: Sizes.height / 84.18,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              switcherValue ? Colors.pinkAccent : Colors.grey),
                    ),
                  ),
                ),
              ),
            );
          case 'setting':
            return Center(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _onTap();
                },
                child: Container(
                  width: Sizes.width / 7.89,
                  height: Sizes.height / 40,
                  decoration: BoxDecoration(
                    color: switcherValue ? Mcolors.medicalGreen : Colors.grey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(99),
                    ),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 100),
                    alignment: switcherValue
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: AnimatedContainer(
                      margin: const EdgeInsets.all(2),
                      duration: const Duration(milliseconds: 100),
                      width: Sizes.height / 64.18,
                      height: Sizes.height / 64.18,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
