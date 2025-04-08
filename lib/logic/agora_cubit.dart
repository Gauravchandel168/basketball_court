import 'dart:async'; // Add this

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/data_providers/http/custom_http_exception.dart';
import '../presentation/routers/app_routers.dart';

part 'agora_state.dart';

class AgoraCubit extends Cubit<AgoraState> {

  // final String appId;
  //
  // final String channelName;
  //
  // final String token;
  //
  // final int uid;

  RtcEngine? engine;

  List<int> remoteUids = [];

  bool isMuted = false;

  bool isSpeakerEnabled = false;

  bool isVideoEnabled = false;
  bool isSwitchCamera = true;

  Timer? _callTimer;
  Duration _callDuration = Duration.zero;

  Duration get callDuration => _callDuration;
  AgoraCubit(
      //{

    // required this.appId,
    //
    // required this.channelName,
    //
    // required this.token,
    //
    // required this.uid,

  //}
  ) : super(AgoraInitial());

  Future<void> initialize({
    required  String appId, required String channelName, required String token,
    required int uid
}) async {

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
           // _startCallTimer();
            print(" joined me");

            emit(AgoraConnected(remoteUids: remoteUids, ));
          },

          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {

            remoteUids.add(remoteUid);
            print(" joined other");
            emit(AgoraUserJoined(remoteUids: List.from(remoteUids)));

          },

          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {

            remoteUids.remove(remoteUid);
            leaveCall();
            AppRouter.navigatorKey.currentState?.pop();

            emit(AgoraUserLeft(remoteUids: List.from(remoteUids)));

          },

          onError: (ErrorCodeType err, String msg) {

           //emit(AgoraError(message: 'Error: $err - $msg'));
            if (ErrorCodeType is CustomHttpException) {
              emit(AgoraError(message: 'Error: $err - $msg'));
            } else {
              emit(AgoraError(message:'Failed to join the call: ${err.toString()}-$msg'));
            }
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
      if (e is CustomHttpException) {
        emit(AgoraError(message:e.error));
      } else {
        emit(AgoraError(message:'Failed to join call: ${e.toString()}'));
      }

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
     // _stopCallTimer();

      remoteUids.clear();

      emit(AgoraDisconnected());

    } catch (e) {

      //emit(AgoraError(message: 'Error leaving call: $e'));
      if (e is CustomHttpException) {
        emit(AgoraError(message:e.error));
      } else {
        emit(AgoraError(message:'Failed to leave the call: ${e.toString()}'));
      }
    }

  }

  @override

  Future<void> close() async {

    await engine?.release();
    //_stopCallTimer();

    super.close();

  }
  // Future<void> _startCallTimer() async {
  //   _callDuration = Duration.zero;
  //   _callTimer = Timer.periodic(Duration(seconds: 1), (_) {
  //     _callDuration += Duration(seconds: 1);
  //     emit(AgoraCallDurationUpdated(duration: _callDuration));
  //   });
  // }

  // Future<void> _stopCallTimer() async {
  //   _callTimer?.cancel();
  //   _callTimer = null;
  //   _callDuration = Duration.zero;
  // }

}
