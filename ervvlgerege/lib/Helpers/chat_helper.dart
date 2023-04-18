import 'package:ervvlgerege/Controllers/chat.dart';
import 'package:ervvlgerege/Helpers/logging.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../Models/chat/conversations.dart';
import '../global_constants.dart';

import 'package:ervvlgerege/views/chat/video_call.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_client/livekit_client.dart' as liveKit;

class ChatHelper {
  var chatC = Get.find<ChatC>();
  final medlog = logger(ChatHelper);
  late Socket socket;
  Msgs msgs = Msgs();
  connect() {
    socket = io(
        Addresses.mArea,
        OptionBuilder().setTransports(['websocket']).setExtraHeaders({
          'token': 'aaaaa'
        }).setQuery({"userId": GlobalHelpers.myUserId}).build());

    socket.onConnect((data) {
      medlog.i("Connected");
    });

    socket.on('resmsg', (data) {
      medlog.wtf('---SOCKET RECIEVED DATA---: $data');
      msgs = Msgs.fromJson(data);
      chatC.convMsjs.add(msgs);
    });

    socket.on("disconnect", (data) => {medlog.i("disconnected")});
    socket.connect();
  }

  bool _simulcast = true;
  bool _adaptiveStream = true;
  bool _dynacast = true;
  bool _fastConnect = false;
  Future<void> joinRoom() async {
    medlog.i('joinRoom method');
    medlog.wtf('---JOIN ROOM---:...........url: ${chatC.roomInfo.data?.url}, '
        'token: ${chatC.roomInfo.data?.token}...');
    final room = Room();
    final listener = room.createListener();
    try {
      await room.connect(
        chatC.roomInfo.data!.url ?? '',
        chatC.roomInfo.data!.token ?? '',
        roomOptions: RoomOptions(
          adaptiveStream: _adaptiveStream,
          dynacast: _dynacast,
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: _simulcast,
          ),
          defaultScreenShareCaptureOptions:
              const ScreenShareCaptureOptions(useiOSBroadcastExtension: true),
        ),
        fastConnectOptions: _fastConnect
            ? FastConnectOptions(
                microphone: const TrackOption(enabled: true),
                camera: const TrackOption(enabled: true),
              )
            : null,
      );
      if (room.connectionState == liveKit.ConnectionState.connected) {
        print('livekit is connected');
        chatC.videoCallServerConnection.value = false;
        Get.to(() => VideoCall(
              room: room,
              listener: listener,
            ));
      }
    } catch (error) {
      print('Could not connect $error');
    } finally {}
  }

  static const _storeKeyUri = 'uri';
  static const _storeKeyToken = 'token';
  static const _storeKeySimulcast = 'simulcast';
  static const _storeKeyAdaptiveStream = 'adaptive-stream';
  static const _storeKeyDynacast = 'dynacast';
  static const _storeKeyFastConnect = 'fast-connect';

  // Future<void> _writePrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_storeKeyUri, chatC.roomInfo.data!.url ?? '');
  //   await prefs.setString(_storeKeyToken, chatC.roomInfo.data!.token ?? '');
  //   await prefs.setBool(_storeKeySimulcast, _simulcast);
  //   await prefs.setBool(_storeKeyAdaptiveStream, _adaptiveStream);
  //   await prefs.setBool(_storeKeyDynacast, _dynacast);
  //   await prefs.setBool(_storeKeyFastConnect, _fastConnect);
  // }
  //   Future<void> _readPrefs() async { //readPrefs iig init ali neg init deer ashiglah ni tohiromtoi
  //   final prefs = await SharedPreferences.getInstance();
  //   _uriCtrl.text = const bool.hasEnvironment('URL')
  //       ? const String.fromEnvironment('URL')
  //       : prefs.getString(_storeKeyUri) ?? '';
  //   _tokenCtrl.text = const bool.hasEnvironment('TOKEN')
  //       ? const String.fromEnvironment('TOKEN')
  //       : prefs.getString(_storeKeyToken) ?? '';
  //   setState(() {
  //     _simulcast = prefs.getBool(_storeKeySimulcast) ?? true;
  //     _adaptiveStream = prefs.getBool(_storeKeyAdaptiveStream) ?? true;
  //     _dynacast = prefs.getBool(_storeKeyDynacast) ?? true;
  //     _fastConnect = prefs.getBool(_storeKeyFastConnect) ?? false;
  //   });
  // }
}
