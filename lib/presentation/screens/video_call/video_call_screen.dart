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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/font_weight.dart';
import '../../../logic/agora_cubit.dart';
import '../../../logic/auth_cubit/user_hybrated_storage__cubit.dart';
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
bool isFull=true;
  @override
  void initState() {
    super.initState();
  }
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AgoraCubit(
        // appId: widget.agoraTokenModel.appId ?? "",
        // channelName: widget.agoraTokenModel.channelId ?? "",
        // token: widget.agoraTokenModel.token ?? "",
        // uid: 0,
      )..initialize(
        appId: widget.agoraTokenModel.appId ?? "",
        channelName: widget.agoraTokenModel.channelId ?? "",
        token: widget.agoraTokenModel.token ?? "",
        uid: 0,
      ),

        child: Scaffold(
          backgroundColor:
          //Colors.transparent,
          Colors.white,
          //Colors.black,
          body: BlocConsumer<AgoraCubit, AgoraState>(

            listener: (context, state) {

              if (state is AgoraError) {

                ScaffoldMessenger.of(context).showSnackBar(

                  SnackBar(content:
                      Text(state.message,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle:
                        const TextStyle(fontSize: 14,
                            fontWeight: bold,
                            color: whiteFFFFFFColor),
                      )),
                  ),

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
                          const TextStyle(fontSize: 19,
                              fontWeight: thick,
                              color: blackFF101010Color),
                        )),
                  );

              }

              return InkWell(
                onTap: (){
                  setState(() {
                    isFull=! isFull;

                  });
                },
                child: Stack(

                  children: [

                    // Remote video views
                   // isFull?
                    //_buildRemoteVideo(cubit,isFull):
                   (cubit.remoteUids.isEmpty) ?
                  AgoraVideoView(

                    controller: VideoViewController(

                      rtcEngine: cubit.engine!,

                      canvas: const VideoCanvas(uid: 0),

                    ),

                  )

                // Center(
                //   child: Text("calling...",
                //       style: GoogleFonts.plusJakartaSans(
                //         textStyle:
                //         const TextStyle(fontSize: 14,
                //             fontWeight: bold,
                //             color: blackFF101010Color),
                //       )),
                // );
              : isFull?
                   AgoraVideoView(

              controller: VideoViewController.remote(

              rtcEngine: cubit.engine!,

              canvas: VideoCanvas(uid: cubit.remoteUids.first),

              connection: RtcConnection(channelId: widget.agoraTokenModel.channelId??""),

              ),

              ):

              Positioned(

              bottom: 130,

              right: 20,

              width: 100,

              height: 150,

              child: Container(
              decoration: BoxDecoration(
              border: Border.all(color: whiteFFFFFFColor, width: 2),
              ),
              width: 140,
              height: 160,
              child: AgoraVideoView(

              controller: VideoViewController.remote(

              rtcEngine: cubit.engine!,

              canvas: VideoCanvas(uid: cubit.remoteUids.first),

              connection: RtcConnection(channelId: widget.agoraTokenModel.channelId??""),

              ),

              ),
              ),

              ),




                   // Local video view

                    cubit.remoteUids.isEmpty?
                    const SizedBox.shrink():
                    isFull?Positioned(

                      bottom: 130,

                      right: 20,

                      width: 100,

                      height: 150,

                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: whiteFFFFFFColor, width: 2),
                        ),
                        width: 140,
                        height: 160,
                        child: AgoraVideoView(

                          controller: VideoViewController(

                            rtcEngine: cubit.engine!,

                            canvas: const VideoCanvas(uid: 0),

                          ),

                        ),
                      ),

                    ):AgoraVideoView(

                      controller: VideoViewController(

                        rtcEngine: cubit.engine!,

                        canvas: const VideoCanvas(uid: 0),

                      ),

                    ),

                    Positioned(

                      bottom: 20,

                      left: 0,

                      right: 0,

                      child: _buildControlButtons(cubit),

                    ),
                    Positioned(
                      top: 60,
                      right: 10,
                      child: _controlButton(
                        iconOn: CupertinoIcons.switch_camera_solid,
                        iconOff: CupertinoIcons.switch_camera_solid,
                        isToggled: cubit.isSwitchCamera,
                        onTap: cubit.switchCamera,
                          backgroundColor: blackFF101010Color,
                        iconColor: whiteFFFFFFColor
                      ),
                    ),
                    cubit.remoteUids.isEmpty?  Align(

                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.agoraTokenModel.userName??"",
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: thick,
                                  color: blackFF101010Color,
                                ),
                              ),
                            ),
                            Text(
                              "Ringing...",
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: bold,
                                  color: blackFF101010Color,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ):
                        SizedBox.shrink(),
                  //  _buildStatusAndDuration(state)
                  ],

                ),
              );

            },

          ),

        ),


    );

  }
  // Widget _buildStatusAndDuration(AgoraState state) {
  //   Duration duration = Duration.zero;
  //
  //   if (state is AgoraConnected || state is AgoraCallDurationUpdated) {
  //     if (state is AgoraConnected) {
  //       duration = state.callDuration;
  //     } else if (state is AgoraCallDurationUpdated) {
  //       duration = state.duration;
  //     }
  //   }
  //   return Positioned(
  //     top: 90,
  //     left: 20,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //
  //           Row(
  //             children: [
  //               const CircleAvatar(backgroundColor: Colors.red, radius: 6),
  //               const SizedBox(width: 10),
  //               Text(
  //                   'Call Duration: ${formatDuration(duration)}',
  //                   style: const TextStyle(color: whiteFFFFFFColor, fontSize: 14)),
  //             ],
  //           ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildRemoteVideo(AgoraCubit cubit, bool isFull) {

    if (cubit.remoteUids.isEmpty) {

       return
        AgoraVideoView(

          controller: VideoViewController(

            rtcEngine: cubit.engine!,

            canvas: const VideoCanvas(uid: 0),

          ),

        );
      // Center(
      //   child: Text("calling...",
      //       style: GoogleFonts.plusJakartaSans(
      //         textStyle:
      //         const TextStyle(fontSize: 14,
      //             fontWeight: bold,
      //             color: blackFF101010Color),
      //       )),
      // );
    }else{

      return isFull?AgoraVideoView(

        controller: VideoViewController.remote(

          rtcEngine: cubit.engine!,

          canvas: VideoCanvas(uid: cubit.remoteUids.first),

          connection: RtcConnection(channelId: widget.agoraTokenModel.channelId??""),

        ),

      ):

    Positioned(

    bottom: 130,

    right: 20,

    width: 100,

    height: 150,

    child: Container(
    decoration: BoxDecoration(
    border: Border.all(color: whiteFFFFFFColor, width: 2),
    ),
    width: 140,
    height: 160,
    child: AgoraVideoView(

    controller: VideoViewController.remote(

    rtcEngine: cubit.engine!,

    canvas: VideoCanvas(uid: cubit.remoteUids.first),

    connection: RtcConnection(channelId: widget.agoraTokenModel.channelId??""),

    ),

    ),
    ),

    );

    }



  }

  Widget _buildControlButtons(AgoraCubit cubit) {

    return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,
           ),

        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15,),
      decoration:const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
            color: blackFF101010Color
      ) ,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          _controlButton(
            iconOn: Icons.mic,
            iconOff: Icons.mic_off,
            isToggled: cubit.isMuted,
            onTap: cubit.toggleMute,
              backgroundColor: cubit.isMuted? whiteFFFFFFColor :
              black878787Color.withOpacity(0.4),
              iconColor: cubit.isMuted? Colors.red  :
              whiteFFFFFFColor
          ),

          _controlButton(
            iconOn: Icons.volume_up,
            iconOff: Icons.volume_off,
            isToggled: cubit.isSpeakerEnabled,
            onTap: cubit.toggleSpeaker,
              backgroundColor: cubit.isSpeakerEnabled? black878787Color.withOpacity(0.4):
              whiteFFFFFFColor,
             iconColor: cubit.isSpeakerEnabled? whiteFFFFFFColor :
             blackFF101010Color

          ),

          _controlButton(
            iconOn: Icons.videocam,
            iconOff: Icons.videocam_off,
            isToggled: cubit.isVideoEnabled,
            onTap: cubit.toggleVideo,
              backgroundColor: cubit.isVideoEnabled? whiteFFFFFFColor :
              black878787Color.withOpacity(0.4),
              iconColor: cubit.isVideoEnabled? Colors.red  :
              whiteFFFFFFColor
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
            iconColor: whiteFFFFFFColor,
          ),
        ],

      ),
    ));

  }


  Widget _controlButton({
    required IconData iconOn,
    required IconData iconOff,
    required bool isToggled,
    required VoidCallback onTap,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return FloatingActionButton(
      shape: const CircleBorder(
      ),
      backgroundColor: backgroundColor ,
          //?? blackFF101010Color.withOpacity(0.9),
      onPressed: onTap,
      child: Icon(
          size: 32,
          isToggled ? iconOff : iconOn,
          color: iconColor
          ),
    );
  }
}
