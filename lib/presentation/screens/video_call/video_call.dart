import 'package:basketball/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../../logic/video_cubit.dart';

class VideoCallScreen extends StatefulWidget {
  final String channelName;

  const VideoCallScreen({super.key, required this.channelName});

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  @override
  void initState() {
    super.initState();
    context.read<VideoCubit>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          final videoCubit = context.read<VideoCubit>();

          return Stack(
            children: [
              // If a remote user has joined, render their video, else display a waiting message
              //main video call screen
              state is VideoConnected
                  ? AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: context.read<VideoCubit>().engine,
                      //  rtcEngine: videoCubit.engine,
                      canvas: VideoCanvas(uid: state.uid),
                      connection: RtcConnection(),
                    ),
                  )
                  // Displays the local user's video view using the Agora engine.
                  : Center(
                    child: Text(
                      "Waiting for user...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

              Positioned(
                top: 40,
                left: 20,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: whiteFFFFFFColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child:
                        // state is VideoInitialized && context.read<VideoCubit>().localVideoController != null
                        // ? AgoraVideoView(controller:context.read<VideoCubit>().localVideoController!)
                        //     : const Center(child: CircularProgressIndicator()),
                        (state is VideoInitialized ||
                                    state is VideoLocalJoined) &&
                                videoCubit.localVideoController != null
                            ?
                            // AgoraVideoView(controller: videoCubit.localVideoController!,)
                            ///new
                            InkWell(
                              onTap: () {
                                // context.read<VideoCubit>().switchCamera;
                              },
                              child: AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine:
                                      context
                                          .read<VideoCubit>()
                                          .engine, // Uses the Agora engine instance
                                  canvas: const VideoCanvas(
                                    uid: 0, // Specifies the local user
                                    renderMode:
                                        RenderModeType
                                            .renderModeHidden, // Sets the video rendering mode
                                  ),
                                ),
                              ),
                            )
                            : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(
                      Icons.mic_off,
                      Icons.mic,
                      state is VideoMuted && state.isMuted,
                      context.read<VideoCubit>().toggleMute,
                    ),
                    SizedBox(width: 20),
                    _buildIcon(
                      Icons.switch_camera,
                      Icons.switch_camera,
                      false,
                      context.read<VideoCubit>().switchCamera,
                    ),
                    SizedBox(width: 20),
                    _buildIcon(Icons.call_end, Icons.call_end, false, () {
                      context.read<VideoCubit>().leaveCall();
                      Navigator.pop(context);
                    }, color: Colors.red),
                  ],
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<VideoCubit>().joinCall(
            channelName: widget.channelName
        ),
       // shape: CircleBorder(),
       // backgroundColor: green2EC35FColor,
        backgroundColor:  Colors.grey[800],

        child: Icon(size: 38, Icons.video_camera_front_sharp,
            color: green2EC35FColor),
      ),
    );
  }

  Widget _buildIcon(
    IconData iconOff,
    IconData iconOn,
    bool isActive,
    VoidCallback onPressed, {
    Color? color,
  }) {
    return FloatingActionButton(
      backgroundColor: color ?? Colors.grey[800],
      child: Icon(isActive ? iconOff : iconOn, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'cubit/video_cubit.dart';
// import 'cubit/video_state.dart';
//
// class VideoCallScreen extends StatefulWidget {
//   final String channelName;
//
//   VideoCallScreen({required this.channelName});
//
//   @override
//   _VideoCallScreenState createState() => _VideoCallScreenState();
// }
//
// class _VideoCallScreenState extends State<VideoCallScreen> {
//   final String appId = "YOUR_APP_ID";  // Replace with your Agora App ID
//   final String token = "YOUR_TEMPORARY_TOKEN";  // Replace with a valid token
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<VideoCubit>().initializeAgora(appId, widget.channelName, token);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: BlocBuilder<VideoCubit, VideoState>(
//         builder: (context, state) {
//           final videoCubit = context.read<VideoCubit>();
//
//           return Stack(
//             children: [
//               state is VideoConnected
//                   ? AgoraVideoView(
//                 controller: VideoViewController.remote(
//                   rtcEngine: videoCubit._engine,
//                   canvas: VideoCanvas(uid: state.uid),
//                 ),
//               )
//                   : Center(
//                 child: Text(
//                   "Waiting for user...",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               Positioned(
//                 bottom: 20,
//                 left: 20,
//                 child: Container(
//                   width: 100,
//                   height: 150,
//                   child: AgoraVideoView(
//                     controller: VideoViewController(
//                       rtcEngine: videoCubit._engine,
//                       canvas: VideoCanvas(uid: 0),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 30,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     FloatingActionButton(
//                       backgroundColor: Colors.grey[800],
//                       child: Icon(Icons.call_end, color: Colors.red),
//                       onPressed: () {
//                         videoCubit.leaveCall();
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
