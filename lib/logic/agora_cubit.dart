import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'agora_state.dart';

// class AgoraCubit extends Cubit<AgoraState> {
//   AgoraCubit() : super(AgoraInitial());
// }

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:permission_handler/permission_handler.dart';

class AgoraCubit extends Cubit<AgoraState> {

  final String appId;

  final String channelName;

  final String token;

  final int uid;

  RtcEngine? engine;

  List<int> remoteUids = [];

  bool isMuted = false;

  bool isSpeakerEnabled = false;

  bool isVideoEnabled = false;
  bool isSwitchCamera = true;

  AgoraCubit({

    required this.appId,

    required this.channelName,

    required this.token,

    required this.uid,

  }) : super(AgoraInitial());

  Future<void> initialize() async {

    try {

      emit(AgoraLoading());

      // Request microphone and camera permissions

      await [Permission.microphone, Permission.camera].request();

      // Create RTC engine instance

      engine = createAgoraRtcEngine();

      await engine!.initialize(RtcEngineContext(appId: appId));

      // Enable video

      await engine!.enableVideo();

      // Set event handlers

      engine!.registerEventHandler(

        RtcEngineEventHandler(

          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {

            emit(AgoraConnected(remoteUids: remoteUids));

          },

          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {

            remoteUids.add(remoteUid);

            emit(AgoraUserJoined(remoteUids: List.from(remoteUids)));

          },

          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {

            remoteUids.remove(remoteUid);

            emit(AgoraUserLeft(remoteUids: List.from(remoteUids)));

          },

          onError: (ErrorCodeType err, String msg) {

            emit(AgoraError(message: 'Error: $err - $msg'));

          },

        ),

      );

      // Join channel

      await engine!.joinChannel(

        token: token,

        channelId: channelName,

        uid: uid,

        options: const ChannelMediaOptions(

          channelProfile: ChannelProfileType.channelProfileCommunication,

          clientRoleType: ClientRoleType.clientRoleBroadcaster,

        ),

      );

    } catch (e) {

      emit(AgoraError(message: 'Initialization failed: $e'));

    }

  }

  Future<void> toggleMute() async {

    await engine?.muteLocalAudioStream(!isMuted);

    isMuted = !isMuted;

    emit(AgoraMuteStateChanged(isMuted: isMuted));

  }

  Future<void> toggleSpeaker() async {

    await engine?.setEnableSpeakerphone(!isSpeakerEnabled);

    isSpeakerEnabled = !isSpeakerEnabled;

    emit(AgoraSpeakerStateChanged(isSpeakerEnabled: isSpeakerEnabled));

  }

  Future<void> toggleVideo() async {

    await engine?.muteLocalVideoStream(!isVideoEnabled);

    isVideoEnabled = !isVideoEnabled;

    emit(AgoraVideoStateChanged(isVideoEnabled: isVideoEnabled));

  }

  Future<void> switchCamera() async {

    await engine?.switchCamera();
    isSwitchCamera = !isSwitchCamera;

    emit(AgoraCameraSwitched( isSwitchCamera: isSwitchCamera));

  }

  Future<void> leaveCall() async {

    try {

      await engine?.leaveChannel();

      remoteUids.clear();

      emit(AgoraDisconnected());

    } catch (e) {

      emit(AgoraError(message: 'Error leaving call: $e'));

    }

  }

  @override

  Future<void> close() async {

    await engine?.release();

    super.close();

  }

}
