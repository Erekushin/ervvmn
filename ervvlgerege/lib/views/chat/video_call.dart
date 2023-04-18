// import 'dart:ffi'; //TODO

import 'package:ervvlgerege/Controllers/chat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter_background/flutter_background.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:ervvlgerege/global_constants.dart';

import '../../Models/chat/video_call.dart';
import '../../MyWidgets/Social/user_profile.dart';
import '../../MyWidgets/chat/video_screen.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({required this.room, required this.listener, super.key});
  final Room room;
  final EventsListener<RoomEvent> listener;
  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  List<ParticipantTrack> participantTracks = [];
  EventsListener<RoomEvent> get _listener => widget.listener;
  bool get fastConnection => widget.room.engine.fastConnectOptions != null;
  @override
  void initState() {
    super.initState();
    widget.room.addListener(_onRoomDidUpdate);
    _setUpListeners();
    _sortParticipants();
    WidgetsBindingCompatible.instance?.addPostFrameCallback((_) {
      if (!fastConnection) {
        _askPublish();
      }
    });
  }

  @override
  void dispose() {
    // always dispose listener
    (() async {
      widget.room.removeListener(_onRoomDidUpdate);
      await _listener.dispose();
      await widget.room.dispose();
    })();
    super.dispose();
  }

  void _setUpListeners() => _listener
    ..on<RoomDisconnectedEvent>((_) async {
      WidgetsBindingCompatible.instance
          ?.addPostFrameCallback((timeStamp) => Navigator.pop(context));
    })
    ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
    ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
    ..on<DataReceivedEvent>((event) {
      String decoded = 'Failed to decode';
      try {
        decoded = utf8.decode(event.data);
      } catch (_) {
        print('Failed to decode: $_');
      }
      context.showDataReceivedDialog(decoded);
    });

  void _askPublish() async {
    // video will fail when running in ios simulator
    try {
      await widget.room.localParticipant?.setCameraEnabled(true);
      await widget.room.localParticipant?.setMicrophoneEnabled(true);
      return;
    } catch (error) {
      print('could not publish video or audio: $error');
      await context.showErrorDialog(error);
    }
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _sortParticipants() {
    List<ParticipantTrack> userMediaTracks = [];
    List<ParticipantTrack> screenTracks = [];
    for (var participant in widget.room.participants.values) {
      for (var t in participant.videoTracks) {
        if (t.isScreenShare) {
          screenTracks.add(ParticipantTrack(
            participant: participant,
            videoTrack: t.track,
            isScreenShare: true,
          ));
        } else {
          userMediaTracks.add(ParticipantTrack(
            participant: participant,
            videoTrack: t.track,
            isScreenShare: false,
          ));
        }
      }
    }
    // sort speakers for the grid
    userMediaTracks.sort((a, b) {
      // loudest speaker first
      if (a.participant.isSpeaking && b.participant.isSpeaking) {
        if (a.participant.audioLevel > b.participant.audioLevel) {
          return -1;
        } else {
          return 1;
        }
      }

      // last spoken at
      final aSpokeAt = a.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
      final bSpokeAt = b.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;

      if (aSpokeAt != bSpokeAt) {
        return aSpokeAt > bSpokeAt ? -1 : 1;
      }

      // video on
      if (a.participant.hasVideo != b.participant.hasVideo) {
        return a.participant.hasVideo ? -1 : 1;
      }

      // joinedAt
      return a.participant.joinedAt.millisecondsSinceEpoch -
          b.participant.joinedAt.millisecondsSinceEpoch;
    });

    final localParticipantTracks = widget.room.localParticipant?.videoTracks;
    if (localParticipantTracks != null) {
      for (var t in localParticipantTracks) {
        if (t.isScreenShare) {
          screenTracks.add(ParticipantTrack(
            participant: widget.room.localParticipant!,
            videoTrack: t.track,
            isScreenShare: true,
          ));
        } else {
          userMediaTracks.add(ParticipantTrack(
            participant: widget.room.localParticipant!,
            videoTrack: t.track,
            isScreenShare: false,
          ));
        }
      }
    }
    setState(() {
      participantTracks = [...screenTracks, ...userMediaTracks];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Expanded(
          child: participantTracks.isNotEmpty
              ? ParticipantWidget.widgetFor(participantTracks.first)
              : Container()),
      SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.all(30),
            child: (participantTracks.length > 1)
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: math.max(0, participantTracks.length - 1),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: ParticipantWidget.widgetFor(
                            participantTracks[index + 1]),
                      );
                    })
                : userProPic(
                    'https://i.pinimg.com/564x/7c/2f/47/7c2f478de45b85fa9b49c220a8e28f7e.jpg',
                    50),
          ),
        ),
      ),
      if (widget.room.localParticipant != null)
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Sizes.width,
              height: Sizes.height * 0.15,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 4,
                    offset: const Offset(0, 0),
                    blurStyle: BlurStyle.outer,
                  )
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                    child: ControlsWidget(
                        widget.room, widget.room.localParticipant!)),
              ),
            ))
    ]));
  }
}

class ControlsWidget extends StatefulWidget {
  const ControlsWidget(
    this.room,
    this.participant, {
    Key? key,
  }) : super(key: key);
  final Room room;
  final LocalParticipant participant;
  @override
  State<StatefulWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  CameraPosition position = CameraPosition.front;

  List<MediaDevice>? _audioInputs;
  List<MediaDevice>? _audioOutputs;
  List<MediaDevice>? _videoInputs;
  MediaDevice? _selectedVideoInput;

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    participant.addListener(_onChange);
    _subscription = Hardware.instance.onDeviceChange.stream
        .listen((List<MediaDevice> devices) {
      _loadDevices(devices);
    });
    Hardware.instance.enumerateDevices().then(_loadDevices);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    participant.removeListener(_onChange);
    super.dispose();
  }

  LocalParticipant get participant => widget.room.localParticipant!;

  void _loadDevices(List<MediaDevice> devices) async {
    _audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
    _audioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();
    _videoInputs = devices.where((d) => d.kind == 'videoinput').toList();
    _selectedVideoInput = _videoInputs?.first;
    setState(() {});
  }

  void _onChange() {
    // trigger refresh
    setState(() {});
  }

  void _disableAudio() async {
    await participant.setMicrophoneEnabled(false);
  }

  Future<void> _enableAudio() async {
    await participant.setMicrophoneEnabled(true);
  }

  void _disableVideo() async {
    await participant.setCameraEnabled(false);
  }

  void _enableVideo() async {
    await participant.setCameraEnabled(true);
  }

  void _selectAudioOutput(MediaDevice device) async {
    await Hardware.instance.selectAudioOutput(device);
    setState(() {});
  }

  void _selectAudioInput(MediaDevice device) async {
    await Hardware.instance.selectAudioInput(device);
    setState(() {});
  }

  void _selectVideoInput(MediaDevice device) async {
    final track = participant.videoTracks.first.track;
    if (track == null) return;
    if (_selectedVideoInput?.deviceId != device.deviceId) {
      await track.switchCamera(device.deviceId);
      _selectedVideoInput = device;
      setState(() {});
    }
  }

  void _toggleCamera() async {
    //
    final track = participant.videoTracks.first.track;
    if (track == null) return;

    try {
      final newPosition = position.switched();
      await track.setCameraPosition(newPosition);
      setState(() {
        position = newPosition;
      });
    } catch (error) {
      print('could not restart track: $error');
      return;
    }
  }

  void _onTapDisconnect() async {
    final result = await context.showDisconnectDialog();
    if (result == true) await widget.room.disconnect();
  }

  void _onTapReconnect() async {
    //TODO
    try {
      await widget.room.reconnect();
      print('reconnect success');
    } catch (error) {
      await context.showErrorDialog(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (participant.isMicrophoneEnabled())
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                onPressed: () async {
                  _disableAudio();
                },
                icon: Icon(
                  FontAwesomeIcons.microphoneLines,
                  size: 30,
                  color: Mcolors.deepGreen,
                ),
                tooltip: 'mute audio',
                iconSize: 40,
              ),
            )
          else
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey),
              child: IconButton(
                onPressed: _enableAudio,
                icon: const Icon(
                  FontAwesomeIcons.microphone,
                  size: 30,
                  color: Colors.white,
                ),
                tooltip: 'un-mute audio',
                iconSize: 40,
              ),
            ),
          if (participant.isCameraEnabled())
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                onPressed: _disableVideo,
                icon: Icon(
                  FontAwesomeIcons.video,
                  size: 30,
                  color: Mcolors.deepGreen,
                ),
                tooltip: 'un-mute video',
                iconSize: 40,
              ),
            )
          else
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey),
              child: IconButton(
                onPressed: _enableVideo,
                icon: const Icon(
                  FontAwesomeIcons.video,
                  size: 30,
                  color: Colors.white,
                ),
                tooltip: 'un-mute video',
                iconSize: 40,
              ),
            ),
          Container(
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.rotate,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () => _toggleCamera(),
              tooltip: 'toggle camera',
              iconSize: 40,
            ),
          ),
          Container(
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: IconButton(
              onPressed: _onTapDisconnect,
              icon: const Icon(
                FontAwesomeIcons.phone,
                size: 30,
                color: Colors.white,
              ),
              tooltip: 'disconnect',
              iconSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}

extension LKExampleExt on BuildContext {
  //

  Future<void> showErrorDialog(dynamic exception) => showDialog<void>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text(exception.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            )
          ],
        ),
      );

  Future<bool?> showDisconnectDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Disconnect'),
          content: const Text('Are you sure to disconnect?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Disconnect'),
            ),
          ],
        ),
      );

  Future<bool?> showDataReceivedDialog(String data) => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Received data'),
          content: Text(data),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

enum SimulateScenarioResult {
  nodeFailure,
  migration,
  serverLeave,
  switchCandidate,
  clear,
}
