// import 'package:basketball/core/colors/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:agora_uikit/agora_uikit.dart';
//
// import '../../../logic/call_cubit.dart';
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
