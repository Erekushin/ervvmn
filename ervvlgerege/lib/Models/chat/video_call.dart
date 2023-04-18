import 'package:livekit_client/livekit_client.dart';

class ParticipantTrack {
  ParticipantTrack(
      {required this.participant,
      required this.videoTrack,
      required this.isScreenShare});
  VideoTrack? videoTrack;
  Participant participant;
  final bool isScreenShare;
}
