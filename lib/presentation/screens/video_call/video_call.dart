import 'package:basketball/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../../logic/video_cubit.dart';
import '../../../widgets/common_appBar.dart';

class VideoCallScreen extends StatefulWidget {
  final String channelName;

  const VideoCallScreen({super.key, required this.channelName});

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   context.read<VideoCubit>().leaveCall();
  // }
  @override
  void initState() {
    super.initState();
    context.read<VideoCubit>().initialize(channelName: widget.channelName);
  }

  @override
  Widget build(BuildContext context) {
    final videoState = context.watch<VideoCubit>().state;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppbar(text: 'Agora Video Call'),

      body: SafeArea(
        child: Stack(
          children: [
            _buildRemoteView(videoState),
            _buildLocalView(videoState),
            _buildControls(videoState),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => context.read<VideoCubit>().joinCall(
        //     channelName: widget.channelName
        // ),
        // shape: CircleBorder(),
        // backgroundColor: green2EC35FColor,
        backgroundColor: Colors.grey[800],

        onPressed: () {},
        child: Icon(
          size: 38,
          Icons.video_camera_front_sharp,
          color: green2EC35FColor,
        ),
      ),
    );
  }

  Widget _buildRemoteView(VideoState state) {
    if (state is VideoConnected) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: context.read<VideoCubit>().engine,
          canvas: VideoCanvas(uid: state.uid),
          connection: RtcConnection(
            channelId: widget.channelName,
            localUid: state.localUid,
          ),
        ),
      );
    } else {
      return const Center(
        child: Text(
          "Waiting for user...",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }
  }

  Widget _buildLocalView(VideoState state) {
    if (state is VideoLocalJoined) {
      return Positioned(
        top:20,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: whiteFFFFFFColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          width: 120,
          height: 160,
          child: AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: context.read<VideoCubit>().engine,
              canvas: const VideoCanvas(uid: 0),
            ),
          ),
        ),
      );
    } else {
      // return const SizedBox();
      return Positioned(
        top:20,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: whiteFFFFFFColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          width: 120,
          height: 160,
          child: Center(
            child: CircularProgressIndicator()
          ),
        ),
      );
    }
  }

  Widget _buildControls(VideoState state) {
    final isMuted = state is VideoMuted && state.isMuted;

    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _controlButton(
            iconOn: Icons.mic,
            iconOff: Icons.mic_off,
            isToggled: isMuted,
            onTap: context.read<VideoCubit>().toggleMute,
          ),
          const SizedBox(width: 20),
          _controlButton(
            iconOn: Icons.switch_camera,
            iconOff: Icons.switch_camera,
            isToggled: false,
            onTap: context.read<VideoCubit>().switchCamera,
          ),
          const SizedBox(width: 20),
          _controlButton(
            iconOn: Icons.call_end,
            iconOff: Icons.call_end,
            isToggled: false,
            onTap: () {
              context.read<VideoCubit>().leaveCall();
              Navigator.pop(context);
            },
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _controlButton({
    required IconData iconOn,
    required IconData iconOff,
    required bool isToggled,
    required VoidCallback onTap,
    Color? backgroundColor,
  }) {
    return FloatingActionButton(
      backgroundColor: backgroundColor ?? Colors.grey[800],
      onPressed: onTap,
      child: Icon(isToggled ? iconOff : iconOn, color: Colors.white),
    );
  }
}

///body: BlocBuilder<VideoCubit, VideoState>(
//         builder: (context, state) {
//          // final videoCubit = context.read<VideoCubit>();
//
//           return SafeArea(
//             child: Stack(
//               children: [
//                 _listofCamera(videoState),
//                 // state is VideoConnected
//                 //
//                 //     ? AgoraVideoView(
//                 //
//                 //       controller: VideoViewController.remote(
//                 //         rtcEngine: context.read<VideoCubit>().engine,
//                 //         //  rtcEngine: videoCubit.engine,
//                 //         canvas: VideoCanvas(uid: state.uid),
//                 //         connection: RtcConnection(
//                 //           channelId: widget.channelName,
//                 //           localUid: state.localUid,
//                 //         ),
//                 //       ),
//                 //     )
//                 //
//                 //     // Displays the local user's video view using the Agora engine.
//                 //     : Center(
//                 //       child: Text(
//                 //         "Waiting for user...",
//                 //         style: TextStyle(color: Colors.white),
//                 //       ),
//                 //     ),
//                 //
//                 // Positioned(
//                 //   top: 40,
//                 //   left: 20,
//                 //   child: Center(
//                 //     child: Container(
//                 //       width: 100,
//                 //       height: 150,
//                 //       decoration: BoxDecoration(
//                 //         border: Border.all(color: whiteFFFFFFColor, width: 2),
//                 //         borderRadius: BorderRadius.all(Radius.circular(12)),
//                 //       ),
//                 //       child:
//                 //           // state is VideoInitialized && context.read<VideoCubit>().localVideoController != null
//                 //           // ? AgoraVideoView(controller:context.read<VideoCubit>().localVideoController!)
//                 //           //     : const Center(child: CircularProgressIndicator()),
//                 //           (state is VideoInitialized ||
//                 //                       state is VideoLocalJoined)
//                 //              // && videoCubit.localVideoController != null
//                 //               ?
//                 //               // AgoraVideoView(controller: videoCubit.localVideoController!,)
//                 //              //  AgoraVideoView(controller:context.read<VideoCubit>().localVideoController!)
//                 //               ///new
//                 //               InkWell(
//                 //                 onTap: () {
//                 //                   // context.read<VideoCubit>().switchCamera;
//                 //                 },
//                 //                 child: AgoraVideoView(
//                 //                   controller: VideoViewController(
//                 //                     rtcEngine:
//                 //                         context
//                 //                             .read<VideoCubit>()
//                 //                             .engine, // Uses the Agora engine instance
//                 //                     canvas: const VideoCanvas(
//                 //                       uid: 0,
//                 //                       // Specifies the local user
//                 //                    //   renderMode: RenderModeType.renderModeFit,
//                 //                       // Sets the video rendering mode
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //               )
//                 //               : const Center(child: CircularProgressIndicator()),
//                 //     ),
//                 //   ),
//                 // ),
//
//                 Positioned(
//                   bottom: 30,
//                   left: 0,
//                   right: 0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildIcon(
//                         Icons.mic_off,
//                         Icons.mic,
//                         state is VideoMuted && state.isMuted,
//                         context.read<VideoCubit>().toggleMute,
//                       ),
//                       SizedBox(width: 20),
//                       _buildIcon(
//                         Icons.switch_camera,
//                         Icons.switch_camera,
//                         false,
//                         context.read<VideoCubit>().switchCamera,
//                       ),
//                       SizedBox(width: 20),
//                       _buildIcon(Icons.call_end, Icons.call_end, false, () {
//                         context.read<VideoCubit>().leaveCall();
//                         Navigator.pop(context);
//                       }, color: Colors.red),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
/// state is VideoConnected
//                 //
//                 //     ? AgoraVideoView(
//                 //
//                 //       controller: VideoViewController.remote(
//                 //         rtcEngine: context.read<VideoCubit>().engine,
//                 //         //  rtcEngine: videoCubit.engine,
//                 //         canvas: VideoCanvas(uid: state.uid),
//                 //         connection: RtcConnection(
//                 //           channelId: widget.channelName,
//                 //           localUid: state.localUid,
//                 //         ),
//                 //       ),
//                 //     )
//                 //
//                 //     // Displays the local user's video view using the Agora engine.
//                 //     : Center(
//                 //       child: Text(
//                 //         "Waiting for user...",
//                 //         style: TextStyle(color: Colors.white),
//                 //       ),
//                 //     ),
//                 //
//                 // Positioned(
//                 //   top: 40,
//                 //   left: 20,
//                 //   child: Center(
//                 //     child: Container(
//                 //       width: 100,
//                 //       height: 150,
//                 //       decoration: BoxDecoration(
//                 //         border: Border.all(color: whiteFFFFFFColor, width: 2),
//                 //         borderRadius: BorderRadius.all(Radius.circular(12)),
//                 //       ),
//                 //       child:
//                 //           // state is VideoInitialized && context.read<VideoCubit>().localVideoController != null
//                 //           // ? AgoraVideoView(controller:context.read<VideoCubit>().localVideoController!)
//                 //           //     : const Center(child: CircularProgressIndicator()),
//                 //           (state is VideoInitialized ||
//                 //                       state is VideoLocalJoined)
//                 //              // && videoCubit.localVideoController != null
//                 //               ?
//                 //               // AgoraVideoView(controller: videoCubit.localVideoController!,)
//                 //              //  AgoraVideoView(controller:context.read<VideoCubit>().localVideoController!)
//                 //               ///new
//                 //               InkWell(
//                 //                 onTap: () {
//                 //                   // context.read<VideoCubit>().switchCamera;
//                 //                 },
//                 //                 child: AgoraVideoView(
//                 //                   controller: VideoViewController(
//                 //                     rtcEngine:
//                 //                         context
//                 //                             .read<VideoCubit>()
//                 //                             .engine, // Uses the Agora engine instance
//                 //                     canvas: const VideoCanvas(
//                 //                       uid: 0,
//                 //                       // Specifies the local user
//                 //                    //   renderMode: RenderModeType.renderModeFit,
//                 //                       // Sets the video rendering mode
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //               )
//                 //               : const Center(child: CircularProgressIndicator()),
//                 //     ),
//                 //   ),
//                 // ),
