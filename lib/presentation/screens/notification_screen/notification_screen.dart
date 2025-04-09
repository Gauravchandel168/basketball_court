

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../logic/agora_cubit.dart';
import '../../routers/app_routers.dart';
import '../video_call/widget/incoming_call_banner.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          primary: true,
          actionsPadding: EdgeInsets.zero,
          backgroundColor: green2EC35FColor,
          leading: InkWell(
            onTap: () {
              AppRouter.navigatorKey.currentState?.pop();
            },
            child:const Icon(Icons.arrow_back_ios,
              color: whiteFFFFFFColor,
            ),
          ),
            title: Text(
              "Incoming call",
              style: GoogleFonts.plusJakartaSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: bold,
                  color: whiteFFFFFFColor,

                ),
              ),
            )
        ),

        body: BlocConsumer<AgoraCubit, AgoraState>(
         listener: (context, state) {
           if (state is AgoraUserJoined && state.remoteUids.isNotEmpty) {
             showDialog(
               context: context,
              // barrierDismissible: false,
               builder: (context) => IncomingCallBanner(
                 callerName: 'Caller ${state.remoteUids.first}', // customize if needed
                 callerAvatarUrl: '', // you can add user profile image here
                 onAccept: () {
                   AppRouter.navigatorKey.currentState?.pop(); // Close dialog
                 },
                 onDecline: () {
                   context.read<AgoraCubit>().leaveCall(); // Leave call
                   AppRouter.navigatorKey.currentState?.pop(); // Close dialog
                 },
               ),
             );
           }
         },
         builder: (context, state) {
           final cubit = context.read<AgoraCubit>();

           // if (state is AgoraInitial || state is AgoraLoading) {
           //
           //   return
           //      Center(
           //       child: Text("calling...",
           //           style: GoogleFonts.plusJakartaSans(
           //             textStyle:
           //             const TextStyle(fontSize: 19,
           //                 fontWeight: thick,
           //                 color: blackFF101010Color),
           //           )),
           //     );
           //
           // }
            return (cubit.remoteUids.isEmpty) ? const Center(
              child: Text("Waiting for someone to call you..."),
            ):
            IncomingCallBanner(
              callerName: 'Saakar', // customize if needed
              callerAvatarUrl: '', // you can add user profile image here
              onAccept: () {
                AppRouter.navigatorKey.currentState?.pop(); // Close dialog
              },
              onDecline: () {
                context.read<AgoraCubit>().leaveCall(); // Leave call
                AppRouter.navigatorKey.currentState?.pop(); // Close dialog
              },
            );
         },
             ),
      );

  }
}
