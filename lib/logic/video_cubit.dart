import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'video_state.dart';

const String appId = "dee7af634433419e96023a393890962c";
//const String appId = "YOUR_AGORA_APP_ID";
//const String channelName = "basketball";
const String token = "007eJxTYOib9dLE1z7+3MuYyti3Cbu/8ka5Tgmadnd31uxvXdIJJfMUGFJSU80T08yMTUyMjU0MLVMtzQyMjBONLY0tLA0szYySpfrfpTcEMjJI761gZWSAQBCfiyEpsTg7tSQpMSeHgQEAZzEiUg==";
//const String token = "YOUR_AGORA_TEMP_TOKEN";

class VideoCubit extends Cubit<VideoState> {
  late RtcEngine engine;
  late VideoViewController localVideoController;
  int? remoteUid;

  bool isMuted = false;

  VideoCubit() : super(VideoInitial());

// Set up the Agora RTC engine instance
// Register an event handler for Agora RTC

setUserId(int? remoteUid){
  this.remoteUid=remoteUid;
}
  Future<void> initialize() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(appId: appId,
      ///new
      channelProfile: ChannelProfileType.channelProfileCommunication,

    ));

    _setupAgoraHandlers();


    // await engine.enableVideo();
    // ///new
    // await engine.startPreview();
    _setupLocalVideo();
    // Initialize the local video controller after enabling video
    localVideoController = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(uid: 0),
    );

    emit(VideoInitialized()); // Emit a new state to indicate readiness

    // engine.registerEventHandler(
    //     RtcEngineEventHandler(
    //       ///new
    //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
    //         debugPrint("Local user ${connection.localUid} joined");
    //         emit(VideoLocalJoined(connection.localUid ?? 0)); // Emit a state instead of using setState
    //       },
    //   onUserJoined: (RtcConnection connection, int uid, int elapsed) {
    //     emit(VideoConnected(uid));
    //   },
    //   onUserOffline: (RtcConnection connection, int uid, UserOfflineReasonType reason) {
    //     emit(VideoDisconnected());
    //   },
    // ));
  }

  void _setupAgoraHandlers() {
    engine.registerEventHandler(RtcEngineEventHandler(
      ///new

    onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        debugPrint("Local user ${connection.localUid} joined");
        emit(VideoLocalJoined(connection.localUid ?? 0));
      },
      onUserJoined: (RtcConnection connection, int uid, int elapsed) {
        debugPrint("Remote user $uid joined");
        remoteUid = uid;
        emit(VideoConnected(uid));
      },
      onUserOffline: (RtcConnection connection, int uid, UserOfflineReasonType reason) {
        debugPrint("Remote user $uid left the call");
        remoteUid = null;
        emit(VideoDisconnected());
      },
    ));
  }

  Future<void> _setupLocalVideo() async {
    await engine.enableVideo(); // Enable video
    ///new
    await engine.startPreview(); // Start local preview
  }

// Register an event handler for Agora RTC
//   await _engine.joinChannel(token: token,
//   channelId: channelName,
//   uid: 0, options: ChannelMediaOptions());
  Future<void> joinCall({required String channelName}) async {
    emit(VideoLoading());
    await engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(
        /// all new inside it
        autoSubscribeVideo: true, // Automatically subscribe to all video streams
        autoSubscribeAudio: true, // Automatically subscribe to all audio streams
        publishCameraTrack: true, // Publish camera-captured video
        publishMicrophoneTrack: true, // Publish microphone-captured audio
        // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
    emit(VideoInCall());
  }

  void toggleMute() {
    isMuted = !isMuted;
    engine.muteLocalAudioStream(isMuted);
    emit(VideoMuted(isMuted));
  }

  Future<void> switchCamera() async {
    await engine.switchCamera();
  }

  Future<void> leaveCall() async {
    await engine.leaveChannel();
    emit(VideoDisconnected());
  }
}

