// import 'package:basketball/core/colors/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:agora_uikit/agora_uikit.dart';
//
// import '../../../logic/agoras_cubit.dart';
// import '../../../widgets/common_appBar.dart';
//
// class VideoCallScreen extends StatefulWidget {
//   final String channelName;
//
//   const VideoCallScreen({super.key, required this.channelName});
//
//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }
//
// class _VideoCallScreenState extends State<VideoCallScreen> {
//   late final AgoraClient client;
//   final String appId = "dee7af634433419e96023a393890962c";
//   final String token =
//       "007eJxTYGjXVgybuGcRo/mMqlILt8BfPcve+eZGf74fl1X7awPDzwsKDCmpqeaJaWbGJibGxiaGlqmWZgZGxonGlsYWlgaWZkbJ+99+SG8IZGTIrWFjZGSAQBCfiyEpsTg7tSQpMSeHgQEANGciaQ==";
//
//   @override
//   void initState() {
//     super.initState();
//     client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//         appId: appId,
//         channelName: widget.channelName,
//         tempToken: token, // Optional
//       ),
//       // enabledPermission: [
//       //   Permission.camera,
//       //   Permission.contacts,
//       //   Permission.microphone
//       // ]
//     );
//     initAgora();
//   }
//
//   Future<void> initAgora() async {
//     await client.initialize();
//     context.read<CallCubit>().joinCall();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CallCubit, CallState>(
//       listener: (context, state) {
//         if (state is CallLeft) {
//           Navigator.pop(context);
//         }
//       },
//       builder: (context, state) {
//         if (state is CallJoined) {
//           return Scaffold(
//             backgroundColor: Colors.black,
//        appBar: CommonAppbar(text: 'Agora Video Call'),
//             body: SafeArea(
//               child: Stack(
//                 children: [
//                   AgoraVideoViewer(
//                     client: client,
//                     layoutType: Layout.floating,
//                     enableHostControls: true,
//                   ),
//                   AgoraVideoButtons(
//                     client: client,
//
//                     disconnectButtonChild:
//                     FloatingActionButton(
//                       backgroundColor:Colors.red ,
//                       shape: CircleBorder(),
//                       onPressed: () {
//                         client.engine.leaveChannel();
//                         context.read<CallCubit>().leaveCall();
//                       },
//                       child: const Icon(
//                         Icons.call_end,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//
//         return const Scaffold(
//           body: Center(
//             child: SizedBox(
//               child: CircularProgressIndicator(color: purple4C4DDCColor),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:basketball/core/colors/app_colors.dart';
import 'package:basketball/presentation/routers/app_routers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/font_weight.dart';
import '../../../logic/agora_cubit.dart';
import '../forget_password_screen/widget/agoraTokenmodel.dart';


class VideoCallPage extends StatefulWidget {
  final AgoraTokenModel agoraTokenModel;

  const VideoCallPage({
    super.key, required this.agoraTokenModel,
  });

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (context) => AgoraCubit(
        appId: widget.agoraTokenModel.appId ?? "",
        channelName: widget.agoraTokenModel.channelId ?? "",
        token: widget.agoraTokenModel.token ?? "",
        uid: 0,

      )..initialize(),

        child: Scaffold(
          backgroundColor:
          Colors.black,
          body: BlocConsumer<AgoraCubit, AgoraState>(

            listener: (context, state) {

              if (state is AgoraError) {

                ScaffoldMessenger.of(context).showSnackBar(

                  SnackBar(content: Text(state.message)),

                );

              }

            },

            builder: (context, state) {

              final cubit = context.read<AgoraCubit>();

              if (state is AgoraInitial || state is AgoraLoading) {

                return
                 // const Center(child: CircularProgressIndicator());
                  Center(
                    child: Text("calling...",
                        style: GoogleFonts.plusJakartaSans(
                          textStyle:
                          const TextStyle(fontSize: 14,
                              fontWeight: bold,
                              color: whiteFFFFFFColor),
                        )),
                  );

              }

              return SafeArea(
                child: Stack(

                  children: [

                    // Remote video views

                    _buildRemoteVideo(cubit),

                    // Local video view

                    Positioned(

                      bottom: 100,

                      right: 20,

                      width: 100,

                      height: 150,

                      child: AgoraVideoView(

                        controller: VideoViewController(

                          rtcEngine: cubit.engine!,

                          canvas: const VideoCanvas(uid: 0),

                        ),

                      ),

                    ),

                    // Controls

                    Positioned(

                      bottom: 20,

                      left: 0,

                      right: 0,

                      child: _buildControlButtons(cubit),

                    ),

                  ],

                ),
              );

            },

          ),

        ),


    );

  }

  Widget _buildRemoteVideo(AgoraCubit cubit) {

    if (cubit.remoteUids.isEmpty) {

      return
      Center(
        child: Text("calling...",
            style: GoogleFonts.plusJakartaSans(
              textStyle:
              const TextStyle(fontSize: 14,
                  fontWeight: bold,
                  color: whiteFFFFFFColor),
            )),
      );
    }

    return AgoraVideoView(

      controller: VideoViewController.remote(

        rtcEngine: cubit.engine!,

        canvas: VideoCanvas(uid: cubit.remoteUids.first),

        connection: RtcConnection(channelId: cubit.channelName),

      ),

    );

  }

  Widget _buildControlButtons(AgoraCubit cubit) {

    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        _controlButton(
          iconOn: Icons.mic,
          iconOff: Icons.mic_off,
          isToggled: cubit.isMuted,
          onTap: cubit.toggleMute,
        ),

        _controlButton(
          iconOn: Icons.volume_up,
          iconOff: Icons.volume_off,
          isToggled: cubit.isSpeakerEnabled,
          onTap: cubit.toggleSpeaker,
        ),

        _controlButton(
          iconOn: Icons.videocam,
          iconOff: Icons.videocam_off,
          isToggled: cubit.isVideoEnabled,
          onTap: cubit.toggleVideo,
        ),
        _controlButton(
          iconOn: Icons.switch_camera,
          iconOff: Icons.switch_camera,
          isToggled: cubit.isSwitchCamera,
          onTap: cubit.switchCamera,
        ),

        _controlButton(
          iconOn: Icons.call_end,
          iconOff: Icons.call_end,
          isToggled: false,
          onTap: () {
            cubit.leaveCall();
            AppRouter.navigatorKey.currentState?.pop();
          },
          backgroundColor: Colors.red,
        ),
      ],

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
      shape: CircleBorder(),
      backgroundColor: backgroundColor ?? blackFF101010Color.withOpacity(0.5),
      onPressed: onTap,
      child: Icon(isToggled ? iconOff : iconOn, color: Colors.white),
    );
  }
}
