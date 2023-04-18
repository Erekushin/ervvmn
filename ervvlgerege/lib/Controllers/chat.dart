import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Helpers/logging.dart';
import '../Models/chat/conversations.dart';
import '../Models/chat/room_info.dart';
import '../global_constants.dart';

class ChatC extends GetxController {
  final medlog = logger(ChatC);
  var searchChattyPerson = TextEditingController();
  var chatMsgC = TextEditingController();

  ConvsM convsM = ConvsM();
  var consList = <EachConvM>[].obs;

  var convMsjs = <Msgs>[].obs;

  Future getConvs() async {
    var data = await GlobalHelpers.apiReq.postdata(
        {"id": GlobalHelpers.myUserId}, '${Addresses.mArea}get-convs');
    medlog.wtf(
        '---GET CONVS---: sent data ${GlobalHelpers.myUserId}: ............ returned data: $data');
    convsM = ConvsM.fromJson(jsonDecode(data.toString()));
    if (!convsM.error!) {
      consList.value = convsM.data!;
      Get.toNamed(RouteUnits.chathome);
    }
  }

  EachConvMsjs eachConvMsjs = EachConvMsjs();
  Future getMsjs(EachConvM eachConvM) async {
    var data = await GlobalHelpers.apiReq
        .postdata({"conId": eachConvM.id}, '${Addresses.mArea}get-msgs');
    medlog.wtf(
        '---GET MSJS---: sent data : ${eachConvM.id}............ returned data: $data');
    eachConvMsjs = EachConvMsjs.fromJson(jsonDecode(data.toString()));
    if (!eachConvMsjs.error!) {
      convMsjs.value = eachConvMsjs.data!;
      Get.toNamed(RouteUnits.conversation, arguments: eachConvM);
    }
  }

  //#region get conversation test api.......................
  ConversationM conversationM = ConversationM();
  Future getConversation(int conId) async {
    var data = await GlobalHelpers.apiReq
        .postdata({"id": conId}, '${Addresses.mArea}get-conv');
    medlog.wtf(
        '---GET CHOSEN CONVERSATION---: sent data : $conId............ returned data: $data');
    conversationM = ConversationM.fromJson(jsonDecode(data.toString()));
    if (!conversationM.error!) {
      Get.toNamed(RouteUnits.conversation);
    }
  }
  //#endregion get conversation test api.....................

  //#region push(emit) message test api............................
  Map<String, dynamic> pushMsjB(int convId) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conId'] = convId;
    data['msg'] = chatMsgC.text;
    data['type'] = 'text';
    data['owner'] = GlobalHelpers.myUserId;
    data['seen'] = [GlobalHelpers.myUserId];
    return data;
  }

  MsgM msjB = MsgM();
  Future pushMsj(int convId) async {
    var data = await GlobalHelpers.apiReq
        .postdata(pushMsjB(convId), '${Addresses.mArea}create-msg');
    medlog.wtf('---PUSH MSJ---: sent data: ........... returned data $data');
    msjB = MsgM.fromJson(jsonDecode(data.toString()));
    if (!msjB.error!) {
      chatMsgC.clear();
      convMsjs.add(msjB.data!);
    }
  }

  //#endregion push(emit) message test api............................

  //videoCall
  var videoCallServerConnection = false.obs;
  Map<String, dynamic> joinRoomB(String roomId) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = GlobalHelpers.myUserId.toString();
    data['roomName'] = roomId;
    return data;
  }

  RoomInfo roomInfo = RoomInfo();
  Future joinRoom(String roomId) async {
    try {
      var data = await GlobalHelpers.apiReq
          .postdata(joinRoomB(roomId), '${Addresses.mArea}vcall/joinroom');
      medlog.wtf('---PUSH MSJ---: sent data: ${{
        "userId": GlobalHelpers.myUserId,
        "roomName": roomId
      }}........... returned data $data');
      roomInfo = RoomInfo.fromJson(jsonDecode(data.toString()));
    } catch (e) {
      print(e);
    }
    if (!(roomInfo.error ?? true)) {
      // Get.to(() => VideoCall());
      // videoCallServerConnection.value =
      //     await GlobalHelpers.chatHelper.joinRoom();
      GlobalHelpers.chatHelper.joinRoom();
    }
  }
}
