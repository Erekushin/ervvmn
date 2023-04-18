import 'package:ervvlgerege/Controllers/chat.dart';
import 'package:ervvlgerege/MyWidgets/Social/user_profile.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:ervvlgerege/views/chat/video_call.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Models/chat/conversations.dart';
import '../../MyWidgets/app/app_bar/appbar_chat.dart';
import '../../MyWidgets/fundamental/text_heading.dart';

import 'package:livekit_client/livekit_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  //---------------------

  static const _storeKeyUri = 'uri';
  static const _storeKeyToken = 'token';
  static const _storeKeySimulcast = 'simulcast';
  static const _storeKeyAdaptiveStream = 'adaptive-stream';
  static const _storeKeyDynacast = 'dynacast';
  static const _storeKeyFastConnect = 'fast-connect';

  bool _simulcast = true;
  bool _adaptiveStream = true;
  bool _dynacast = true;
  bool _fastConnect = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollC.hasClients) {
        scrollC.jumpTo(scrollC.position.maxScrollExtent);
      }
    });

    GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.hideNavBar);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setSimulcast(bool? value) async {
    if (value == null || _simulcast == value) return;
    setState(() {
      _simulcast = value;
    });
  }

  void _setAdaptiveStream(bool? value) async {
    if (value == null || _adaptiveStream == value) return;
    setState(() {
      _adaptiveStream = value;
    });
  }

  void _setDynacast(bool? value) async {
    if (value == null || _dynacast == value) return;
    setState(() {
      _dynacast = value;
    });
  }

  void _setFastConnect(bool? value) async {
    if (value == null || _fastConnect == value) return;
    setState(() {
      _fastConnect = value;
    });
  }

  //---------------------

  final argu = Get.arguments as EachConvM;
  var chatC = Get.find<ChatC>();
  var scrollC = ScrollController();
  @override
  emitMsg(String msg) {
    GlobalHelpers.chatHelper.socket.emit(
      "sendmsg",
      {
        'conId': argu.id,
        'msg': msg,
        'type': 'text',
        'owner': GlobalHelpers.myUserId,
        'seen': [GlobalHelpers.myUserId],
        'show': argu.participants
      },
    );
    chatC.chatMsgC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
        return true;
      },
      child: Scaffold(
        appBar: AppbarChat(
          backAction: () {
            GlobalHelpers.bottomnavbarSwitcher.add(BottomNavbarKeys.home);
          },
          title: argu.title ?? '',
          callAction: () {},
          videoCallAction: () {
            chatC.videoCallServerConnection.value = true;
            chatC.joinRoom(argu.id.toString());
          },
          color: Mcolors.geregeBlue,
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: SingleChildScrollView(
                reverse: true,
                controller: scrollC,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //partner info
                    Container(
                      height: Sizes.height * .3,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          userProPic(
                              'https://i.pinimg.com/564x/7c/2f/47/7c2f478de45b85fa9b49c220a8e28f7e.jpg',
                              50),
                          txtForm12(argu.title ?? 'найз'),
                          txtForm13('152 дагагч'),
                          InkWell(
                            child: Icon(
                              FontAwesomeIcons.robot,
                              color: Mcolors.medicalGreen,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Sizes.width * .4,
                          height: 1,
                          color: Colors.black45,
                        ),
                        txtForm11(argu.createdAt!.substring(0, 10)),
                        Container(
                          width: Sizes.width * .4,
                          height: 1,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    GetX<ChatC>(builder: (cont) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cont.convMsjs.length,
                          itemBuilder: (c, i) {
                            var msg = cont.convMsjs[i];

                            return msg.owner == GlobalHelpers.myUserId
                                ? Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 50,
                                                maxWidth: Sizes.width * .6,
                                                minHeight: 10,
                                              ),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                  ),
                                                  color: Mcolors.geregeBlue),
                                              child: chattxt(msg.msg ?? ''),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      (msg == cont.convMsjs.last ||
                                              cont.convMsjs[i + 1].owner !=
                                                  GlobalHelpers.myUserId)
                                          ? txtForm11(
                                              (msg.updatedAt ?? msg.createdAt)!
                                                  .substring(11, 16))
                                          : const SizedBox()
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            //dood taliin element bhguu esvel dood taliin elemt ni oor
                                            (msg == cont.convMsjs.last ||
                                                    cont.convMsjs[i + 1]
                                                            .owner ==
                                                        GlobalHelpers.myUserId)
                                                ? userProPic(
                                                    'https://i.pinimg.com/564x/7c/2f/47/7c2f478de45b85fa9b49c220a8e28f7e.jpg',
                                                    20)
                                                : const SizedBox(
                                                    width: 45,
                                                  ),
                                            const SizedBox(width: 10),
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 50,
                                                maxWidth: Sizes.width * .6,
                                                minHeight: 10,
                                              ),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                  color: Mcolors.deepGreen),
                                              child: chattxt(msg.msg ?? ''),
                                            )
                                          ],
                                        ),
                                      ),
                                      (msg == cont.convMsjs.last ||
                                              cont.convMsjs[i + 1].owner ==
                                                  GlobalHelpers.myUserId)
                                          ? txtForm11(
                                              (msg.updatedAt ?? msg.createdAt)!
                                                  .substring(11, 16))
                                          : const SizedBox()
                                    ],
                                  );
                          });
                    }),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(
                    bottom: 30, top: 30, left: 30, right: 30),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: Sizes.width * .7,
                      child: TextField(
                        onChanged: (value) {},
                        controller: chatC.chatMsgC,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(4),
                          labelText: 'message . . .',
                          hintText: 'message . . .',
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          emitMsg(chatC.chatMsgC.text);
                        },
                        child: const Icon(FontAwesomeIcons.rightLong)),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
            GetX<ChatC>(builder: (cont) {
              return Visibility(
                  visible: cont.videoCallServerConnection.value,
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Mcolors.geregeBlue,
                      ),
                    ),
                  ));
            })
          ],
        ),
      ),
    );
  }
}
