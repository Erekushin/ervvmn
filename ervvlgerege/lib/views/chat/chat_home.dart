import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/chat.dart';
import '../../MyWidgets/app/app_bar/appbar_main.dart';
import '../../MyWidgets/app/search.dart';
import '../../MyWidgets/app/sidebar.dart';
import '../../MyWidgets/chat/chatty_person.dart';
import '../../global_constants.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  GlobalKey<ScaffoldState> menuSidebarKey = GlobalKey<ScaffoldState>();
  var chatC = Get.find<ChatC>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RouteUnits.medicalhome);
        GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
        return true;
      },
      child: Scaffold(
        key: menuSidebarKey,
        endDrawer: SidebarGeneral(
          menuAction: () {
            menuSidebarKey.currentState?.closeEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.chat);
          },
        ),
        appBar: AppbarMain(
          backAction: () {
            Get.offAllNamed(RouteUnits.medicalhome);
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
          },
          title: 'Чат',
          menuAction: () {
            menuSidebarKey.currentState!.openEndDrawer();
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
          },
          color: Mcolors.geregeBlue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            search(chatC.searchChattyPerson),
            const SizedBox(
              height: 25,
            ),
            GetX<ChatC>(builder: (cont) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cont.consList.length,
                  itemBuilder: (c, i) {
                    var eachConv = cont.consList[i];
                    return Column(
                      children: [
                        InkWell(
                            onTap: () {
                              cont.getMsjs(eachConv);
                            },
                            child: ChatPartner(convItem: eachConv)),
                        const Divider(
                          height: 5,
                          thickness: 1,
                        )
                      ],
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
