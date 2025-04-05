import 'dart:async';
import 'dart:developer' as logSink;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../data/data_providers/http/custom_http_exception.dart';

part 'video_state.dart';

const String appId = "dee7af634433419e96023a393890962c";
//const String channelName = "basketball";
//const String token = "YOUR_AGORA_TEMP_TOKEN";

///For u kind information user token is expire u have re genrate it
const String token = "007eJxTYGjXVgybuGcRo/mMqlILt8BfPcve+eZGf74fl1X7awPDzwsKDCmpqeaJaWbGJibGxiaGlqmWZgZGxonGlsYWlgaWZkbJ+99+SG8IZGTIrWFjZGSAQBCfiyEpsTg7tSQpMSeHgQEANGciaQ==";
class VideoCubit extends Cubit<VideoState> {
  late RtcEngine engine;
  late VideoViewController localVideoController;
  int? remoteUid;
  final users = <int?>[];
  int? localUid;

  bool isMuted = false;
   bool isVideoCall=true;

  late Timer _callTimer;
  int _seconds = 0;
  VideoCubit() : super(VideoInitial());

  Future<void> initialize({required String channelName}) async {
    try {
      engine = createAgoraRtcEngine();
      await engine.initialize(
        const RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      await _setupLocalVideo();

      joinCall(channelsName: channelName);

      localVideoController = VideoViewController(
        rtcEngine: engine,
        canvas: const VideoCanvas(uid: 0),
      );

      emit(VideoInitialized());
      _setupAgoraHandlers();
    } catch (e) {
      emit(VideoError(e.toString()));
      if (e is CustomHttpException) {
        emit(VideoError(e.error));
      } else {
        emit(VideoError('Failed to initialize video: ${e.toString()}'));
      }
    }
  }

  void _setupAgoraHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onAudioVolumeIndication: (
          RtcConnection connection,
          List<AudioVolumeInfo> speakers,
          int speakerNumber,
          int totalVolume,
        ) {
          logSink.log(
            '[onAudioVolumeIndication] speakers: ${speakers.toString()}, speakerNumber: $speakerNumber, totalVolume: $totalVolume',
          );
        },

        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          localUid = connection.localUid ?? 0;
          emit(VideoLocalJoined(localUid!));
          startCallTimer();

        },

        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          debugPrint("Remote user $uid joined");
          remoteUid = uid;
          if (localUid != null) {
            emit(VideoConnected(uid: uid, localUid: localUid!));
            startCallTimer();

          }
        },
        onLeaveChannel: (connection, stats) {
          debugPrint("Remote user left the channel");
          remoteUid = null;
          stopCallTimer();

          emit(VideoDisconnected());
        },
        onUserOffline: (
          RtcConnection connection,
          int uid,
          UserOfflineReasonType reason,
        ) {
          debugPrint("Remote user $uid left the call");
          remoteUid = null;
          stopCallTimer();

          emit(VideoDisconnected());
        },

        // onFirstRemoteVideoFrame:(connection, remoteUid, width, height, elapsed) {
        //   debugPrint("First Remote user $remoteUid ${width}*${height}");
        //
        // },
      ),
    );
  }

  Future<void> _setupLocalVideo() async {
    try {
      // if (isVideoCall) {
      //   await engine.enableVideo(); // Enable video
      //   await engine.startPreview(); // Start local preview
      // } else {
      //   await engine.disableVideo();
      // }
      //await engine.enableAudio();
      await engine.enableVideo(); // Enable video
      await engine.startPreview(); // Start local preview
    }
    catch (e) {
      emit(VideoError(e.toString()));
      if (e is CustomHttpException) {
        emit(VideoError(e.error));
      } else {
        emit(VideoError('Failed to initialize call: ${e.toString()}'));
      }
    }
  }

  Future<void> joinCall({required String channelsName}) async {
    try {
      emit(VideoConnecting());

      await engine.joinChannel(
        token: token,
        channelId: channelsName,
        uid: 0,

        options: const ChannelMediaOptions(
          autoSubscribeVideo:
              true, // Automatically subscribe to all video streams
          autoSubscribeAudio:
              true, // Automatically subscribe to all audio streams
          publishCameraTrack: true, // Publish camera-captured video
          publishMicrophoneTrack: true, // Publish microphone-captured audio
          // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
      //emit(VideoInCall());
    } catch (e) {
      emit(VideoError(e.toString()));
      if (e is CustomHttpException) {
        emit(VideoError(e.error));
      } else {
        emit(VideoError('Something went wrong!'));
      }
    }
  }



  void toggleMute() {
    isMuted = !isMuted;
    engine.muteLocalAudioStream(isMuted);
    emit(VideoMuted(isMuted));
  }

  Future<void> switchCamera() async {
    try {
      await engine.switchCamera();
    }
    catch (e) {
      emit(VideoError(e.toString()));
      if (e is CustomHttpException) {
        emit(VideoError(e.error));
      } else {
        emit(VideoError('Failed to switch camera: ${e.toString()}'));
      }
    }
  }

  Future<void> leaveCall() async {
    try {
      await engine.leaveChannel();
      startCallTimer();

      emit(VideoDisconnected());
    }
    catch (e) {
      emit(VideoError(e.toString()));
      if (e is CustomHttpException) {
        emit(VideoError(e.error));
      } else {
        emit(VideoError('Failed to leave the call: ${e.toString()}'));
      }
    }
  }




  void startCallTimer() {
    _callTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      final duration = Duration(seconds: _seconds);
      final formatted = _formatDuration(duration);
      emit(CallDurationUpdated(duration: formatted));
    });
  }

  void stopCallTimer() {
    _callTimer.cancel();
    _seconds = 0;
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  final player = AudioPlayer();

  Future<void> playRingtone() async {
    await player.play(AssetSource('ringtone.mp3'), volume: 1.0,
        //loop: true
    );
  }

  Future<void> stopRingtone() async {
    await player.stop();
  }

  Future<void> disposeEngine() async {
    try {
      await engine.leaveChannel();
      await engine.release();
      stopCallTimer();
    } catch (e) {
      emit(VideoError('Failed to dispose engine: ${e.toString()}'));
    }

  }
}

/// join call
// emit(VideoLoading());
//     await engine.joinChannel(
//       token: token,
//       channelId: channelsName,
//       uid: 0,
//      // options: ChannelMediaOptions(),
//       options: const ChannelMediaOptions(
//         /// all new inside it
//         autoSubscribeVideo: true, // Automatically subscribe to all video streams
//         autoSubscribeAudio: true, // Automatically subscribe to all audio streams
//         publishCameraTrack: true, // Publish camera-captured video
//         publishMicrophoneTrack: true, // Publish microphone-captured audio
//         // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       ),
//     );
//     emit(VideoInCall());

///intilizer
//  Future<void> initialize({required String channelName}) async {
//     engine = createAgoraRtcEngine();
//     await engine.initialize(
//       const RtcEngineContext(
//         appId: appId,
//
//         ///new
//         channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//       ),
//     );
//
//     _setupLocalVideo();
//
//     joinCall(channelsName: channelName);
//
//     // Initialize the local video controller after enabling video
//     localVideoController = VideoViewController(
//       rtcEngine: engine,
//       canvas: const VideoCanvas(uid: 0),
//     );
//
//     emit(VideoInitialized()); // Emit a new state to indicate readiness
//     _setupAgoraHandlers();
//
//     // engine.registerEventHandler(
//     //     RtcEngineEventHandler(
//     //       ///new
//     //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//     //         debugPrint("Local user ${connection.localUid} joined");
//     //         emit(VideoLocalJoined(connection.localUid ?? 0)); // Emit a state instead of using setState
//     //       },
//     //   onUserJoined: (RtcConnection connection, int uid, int elapsed) {
//     //     emit(VideoConnected(uid));
//     //   },
//     //   onUserOffline: (RtcConnection connection, int uid, UserOfflineReasonType reason) {
//     //     emit(VideoDisconnected());
//     //   },
//     // ));
//   }
/// setupLocal
//Future<void> _setupLocalVideo() async {
//       await engine.enableVideo(); // Enable video
//       // await engine.setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
//       // await engine.setClientRole(role: ClientRoleType.clientRoleAudience);
//       ///new
//       await engine.startPreview();
//
//
//    // Start local preview
//   }
