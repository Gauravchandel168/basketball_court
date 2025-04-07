import 'dart:async';
import 'dart:developer' as logSink;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../data/data_providers/http/custom_http_exception.dart';

part 'video_state.dart';

//const String appId = "dee7af634433419e96023a393890962c";
//const String appId = "dee7af634433419e96023a393890962c";

// const String channelName = "basketball";
// //const String channelID = "dd4f9a6a-e870-4d18-9757-dbc052196c78";
// const String tempToken = "007eJxTYGB/svm1odG5w4q5cuzzzyn/uP3usKSzm6jcYamu7RJnLtsqMKSkpponppkZm5gYG5sYWqZamhkYGScaWxpbWBpYmhkle+z+nN4QyMjQK7aDlZEBAkF8FYaUFJM0y0SzRN1UC3MDXZMUQwtdS3NTc92UpGQDUyNDS7NkcwsGBgB+NiZe";

class VideoCubit extends Cubit<VideoState> {
  late RtcEngine engine;
  late VideoViewController localVideoController;
  int? remoteUid;
  final users = <int?>[];
  int? localUid;

  bool isMuted = false;
  bool isVideoCall = true;

  late Timer _callTimer;
  int _seconds = 0;
  VideoCubit() : super(VideoInitial());

  Future<void> initialize({
    required String channelId,
    required String appId,
    required String token,
  }) async {
    emit(VideoLoading());

    try {
      engine = createAgoraRtcEngine();
      await engine.initialize(
        RtcEngineContext(

          appId: appId,
          channelProfile:
          ChannelProfileType.channelProfileLiveBroadcasting,

        ),
      );

      await _setupLocalVideo();

      localVideoController = VideoViewController(
        rtcEngine: engine,
        canvas: const VideoCanvas(uid: 0),
      );

      await joinCall(channelId: channelId, token: token);
      _setupAgoraHandlers();

      emit(
        VideoSuccess(
          message: "Initialized successfully",
          isDuration: true,
          duration: '',
          localUid: localUid,
          remoteUid: remoteUid,
        ),
      );
    } catch (e) {
      final message =
          (e is CustomHttpException)
              ? e.error
              : 'Failed to initialize video: ${e.toString()}';
      emit(VideoError(message));
    }
  }

  void _setupAgoraHandlers() {
    engine.registerEventHandler(


      RtcEngineEventHandler(

        onError: (err, msg) {
          print(err);
          print(msg);
        },
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
          localUid = connection.localUid ?? 0;
          //startCallTimer();

          if (state is VideoSuccess) {
            final videoSuccess = state as VideoSuccess;
            emit(videoSuccess.copyWith(
              message: "Local joined",
              localUid: localUid,
              isDuration: true,
              duration: "",
            ));
          } else {
            emit(VideoSuccess(
              message: "Local user joined",
              isDuration: true,
              duration: "",
              remoteUid: remoteUid,
              localUid: localUid,
            ));
          }
        },


        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          remoteUid = uid;

          if (state is VideoSuccess) {
            final videoSuccess = state as VideoSuccess;
            emit(
              videoSuccess.copyWith(message: "Remote joined",
                  remoteUid: uid),
            );
          } else {
            emit(
              VideoSuccess(
                message: "Remote user joined",
                isDuration: false,
                duration: "",
                remoteUid: uid,
                localUid: localUid,
              ),
            );
          }
        },

        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          stopCallTimer();
          remoteUid = null;

          if (state is VideoSuccess) {
            final videoSuccess = state as VideoSuccess;
            emit(videoSuccess.copyWith(
              message: "Call ended",
              isDuration: false,
              duration: "",
            ));
          } else {
            emit(VideoSuccess(
              message: "Call ended",
              isDuration: false,
              duration: "",
              remoteUid: remoteUid,
              localUid: localUid,
            ));
          }
        },


        onUserOffline: (
            RtcConnection connection,
            int uid,
            UserOfflineReasonType reason,
            ) {
          debugPrint("Remote user $uid left the call. Reason: $reason");
          remoteUid = null;
          stopCallTimer();

          if (state is VideoSuccess) {
            final videoSuccess = state as VideoSuccess;
            emit(videoSuccess.copyWith(
              message: "Remote user left",
              isDuration: false,
              duration: "",
              remoteUid: null,
            ));
          } else {
            emit(VideoSuccess(
              message: "Remote user left",
              localUid: localUid,
              isDuration: false,
              duration: "",
              remoteUid: null,
            ));
          }
        },

      ),
    );
  }

  Future<void> _setupLocalVideo() async {
    if (state is VideoSuccess) {
      VideoSuccess videoSuccess = (state as VideoSuccess);
      try {
        await engine.enableVideo(); // Enable video
        await engine.startPreview(); // Start local preview

        emit(
          VideoSuccess(
            message: "Local video setup complete",
            duration: videoSuccess.duration,
            isDuration: false,
            remoteUid: videoSuccess.remoteUid,
            localUid: videoSuccess.localUid,
          ),
        );
      } catch (e) {
        if (e is CustomHttpException) {
          emit(VideoError(e.error));
        } else {
          emit(VideoError('Failed to initialize call: ${e.toString()}'));
        }
      }
    }
  }

  Future<void> joinCall({
    required String channelId,
    required String token,
  }) async {
    emit(VideoLoading());
    try {
      await engine.joinChannel(
        token: token,
        channelId: channelId,
        uid: 0,
        options: const ChannelMediaOptions(
          autoSubscribeVideo: true,
          autoSubscribeAudio: true,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
      emit(
        VideoSuccess(
          message: "Joined channel",
          isDuration: true,
          duration: '',
          remoteUid: remoteUid,
          localUid: localUid,
        ),
      );
    } catch (e) {
      final message =
          (e is CustomHttpException)
              ? e.error
              : 'Failed to join call: ${e.toString()}';
      emit(VideoError(message));
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
    } catch (e) {
      emit(VideoError(e.toString()));
      if (e is CustomHttpException) {
        emit(VideoError(e.error));
      } else {
        emit(VideoError('Failed to switch camera: ${e.toString()}'));
      }
    }
  }

  Future<void> leaveCall() async {
    if (state is VideoSuccess) {
      VideoSuccess videoSuccess = (state as VideoSuccess);
      try {
        await engine.leaveChannel();
        await engine.disableVideo();
        await engine.stopPreview();
        await engine.release();
        stopCallTimer(); // changed from startCallTimer() to stopCallTimer() assuming it's leaving

        emit(
          VideoSuccess(
            message: "Call ended",
            localUid: videoSuccess.localUid,
            duration: videoSuccess.duration,
            isDuration: false,
            remoteUid: videoSuccess.remoteUid,
          ),
        );
      } catch (e) {
        if (e is CustomHttpException) {
          emit(VideoError(e.error));
        } else {
          emit(VideoError('Failed to leave the call: ${e.toString()}'));
        }
      }
    }
  }

  void startCallTimer() {
    if (state is VideoSuccess) {
      VideoSuccess videoSuccess = (state as VideoSuccess);

      _callTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _seconds++;
        final duration = Duration(seconds: _seconds);
        final formatted = _formatDuration(duration);
        emit(
          VideoSuccess(
            duration: formatted,
            isDuration: true,
            localUid: videoSuccess.localUid,
            message: videoSuccess.message,
            remoteUid: videoSuccess.remoteUid,
          ),
        );
      });
    }
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
    await player.play(
      AssetSource('ringtone.mp3'),
      volume: 1.0,
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

/// new latest
// Future<void> leaveCall() async {
//   //   try {
//   //     await engine.leaveChannel();
//   //     await engine.disableVideo();
//   //     await engine.stopPreview();
//   //     await engine.release();
//   //     startCallTimer();
//   //
//   //     emit(VideoDisconnected());
//   //   }
//   //   catch (e) {
//   //     emit(VideoError(e.toString()));
//   //     if (e is CustomHttpException) {
//   //       emit(VideoError(e.error));
//   //     } else {
//   //       emit(VideoError('Failed to leave the call: ${e.toString()}'));
//   //     }
//   //   }
//   // }
// Future<void> joinCall({required String channelId,required String token}) async {
//   try {
//     emit(VideoConnecting());
//
//     await engine.joinChannel(
//       token:token ,
//       channelId: channelId,
//       uid: 0,
//
//       options: const ChannelMediaOptions(
//         autoSubscribeVideo:
//             true, // Automatically subscribe to all video streams
//         autoSubscribeAudio:
//             true, // Automatically subscribe to all audio streams
//         publishCameraTrack: true, // Publish camera-captured video
//         publishMicrophoneTrack: true, // Publish microphone-captured audio
//         // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       ),
//     );
//     //emit(VideoInCall());
//   } catch (e) {
//     emit(VideoError(e.toString()));
//     if (e is CustomHttpException) {
//       emit(VideoError(e.error));
//     } else {
//       emit(VideoError('Something went wrong!'));
//     }
//   }
// }

// onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//   debugPrint("Local user ${connection.localUid} joined");
//   localUid = connection.localUid ?? 0;
//   emit(VideoLocalJoined(localUid!));
//   startCallTimer();
//
// },
//
// onUserJoined: (RtcConnection connection, int uid, int elapsed) {
//   debugPrint("Remote user $uid joined");
//   remoteUid = uid;
//   if (localUid != null) {
//     emit(VideoConnected(uid: uid, localUid: localUid!));
//     startCallTimer();
//
//   }
// },
// onLeaveChannel: (connection, stats) {
//   debugPrint("Remote user left the channel");
//   remoteUid = null;
//   stopCallTimer();
//
//   emit(VideoDisconnected());
// },
// onUserOffline: (
//   RtcConnection connection,
//   int uid,
//   UserOfflineReasonType reason,
// ) {
//   debugPrint("Remote user $uid left the call");
//   remoteUid = null;
//   stopCallTimer();
//
//   emit(VideoDisconnected());
// },

// Future<void> initialize({required String channelId,
//   required String appId,
//   required String token,
// }) async {
//
//   try {
//     engine = createAgoraRtcEngine();
//     await engine.initialize(
//        RtcEngineContext(
//         appId:appId,
//         channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//       ),
//     );
//
//     await _setupLocalVideo();
//
//     joinCall(channelId: channelId,token:token );
//     _setupAgoraHandlers();
//
//     localVideoController = VideoViewController(
//       rtcEngine: engine,
//       canvas: const VideoCanvas(uid: 0),
//     );
//
//     emit(VideoInitialized());
//   } catch (e) {
//     emit(VideoError(e.toString()));
//     if (e is CustomHttpException) {
//       emit(VideoError(e.error));
//     } else {
//       emit(VideoError('Failed to initialize video: ${e.toString()}'));
//     }
//   }
// }

//  Future<void> _setupLocalVideo() async {
//     try {
//       // if (isVideoCall) {
//       //   await engine.enableVideo(); // Enable video
//       //   await engine.startPreview(); // Start local preview
//       // } else {
//       //   await engine.disableVideo();
//       // }
//       //await engine.enableAudio();
//       await engine.enableVideo(); // Enable video
//       await engine.startPreview(); // Start local preview
//     }
//     catch (e) {
//       emit(VideoError(e.toString()));
//       if (e is CustomHttpException) {
//         emit(VideoError(e.error));
//       } else {
//         emit(VideoError('Failed to initialize call: ${e.toString()}'));
//       }
//     }
//   }

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
