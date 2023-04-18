import 'package:ervvlgerege/Controllers/search.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../MyWidgets/app/app_bar/appbar_square.dart';
import '../../MyWidgets/app/search.dart';
import '../../MyWidgets/app/sidebar.dart';
import '../../MyWidgets/app/widget_combo.dart';
import '../../MyWidgets/search/search_user.dart';
import '../medical/doctor_pro.dart';

class SearchV extends StatefulWidget {
  const SearchV({super.key});

  @override
  State<SearchV> createState() => _SearchVState();
}

class _SearchVState extends State<SearchV> {
  GlobalKey<ScaffoldState> menuSidebarKey = GlobalKey<ScaffoldState>();
  var searchC = Get.find<SearchC>();
  @override
  void initState() {
    super.initState();
    GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
  }

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
          title: '',
          backAction: () {},
          menuAction: () {
            menuSidebarKey.currentState!.openEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
          },
          color: Mcolors.geregeBlue,
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: Sizes.height * .15 + 40),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 25,
                      itemBuilder: (c, i) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => const DoctorPro());
                            },
                            child: userSearchComponent());
                      })),
            ),
            Column(
              children: [
                Container(
                    width: Sizes.width,
                    height: Sizes.height * .15,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Mcolors.geregeBlue),
                    child: Center(child: search(searchC.searchTxtC))),
                const SizedBox(
                  height: 5,
                ),
                const SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: Searchbtns()),
              ],
            )
          ],
        ));
  }
}
