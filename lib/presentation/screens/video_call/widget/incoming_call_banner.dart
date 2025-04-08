
import 'package:basketball/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/font_weight.dart';

class IncomingCallBanner extends StatefulWidget {
  final String callerName;
  final String callerAvatarUrl;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const IncomingCallBanner({super.key,
    required this.callerName,
    required this.callerAvatarUrl,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  State<IncomingCallBanner> createState() => _IncomingCallBannerState();
}

class _IncomingCallBannerState extends State<IncomingCallBanner> {

  @override
  Widget build(BuildContext context) {
   return Align(
     alignment: Alignment.topCenter,
     child: Container(
       // width: double.infinity  ,
       margin: EdgeInsets.symmetric( vertical: 32),
       padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
       decoration: BoxDecoration(
         color: blackFF101010Color,
         borderRadius: BorderRadius.circular(40),
       ),
       child: Row(
         children: [
           CircleAvatar(
             radius: 20,
             backgroundColor: Colors.grey,
             backgroundImage: NetworkImage(widget.callerAvatarUrl),
           ),
           SizedBox(width: 12),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                     widget.callerName,
                     overflow: TextOverflow.ellipsis,
                     style: GoogleFonts.plusJakartaSans(
                       textStyle: const TextStyle(
                           color: Colors.white,
                           fontSize: 14,
                           fontWeight: bold
                       ),
                     )
                 ),
                 Row(
                   children: [
                     Icon(Icons.videocam, size: 14, color: Colors.grey),
                     SizedBox(width: 4),
                     Text(
                         "Incoming Video Call",
                         style: GoogleFonts.plusJakartaSans(
                           textStyle: const TextStyle(
                               color: Colors.grey,
                               fontSize: 12,
                               fontWeight: normal
                           ),
                         )
                     ),

                   ],
                 )
               ],
             ),
           ),
           Row(
             children: [

               Container(
                 width: 45,
                 child: FloatingActionButton(

                   shape: const CircleBorder(
                   ),
                   backgroundColor: Colors.red ,
                   onPressed:  widget.onDecline,
                   child: const Icon(Icons.call_end, color: Colors.white),
                 ),
               ),
               SizedBox(width: 18,),

               Container(
                 width: 45,

                 child: FloatingActionButton(
                   shape: const CircleBorder(
                   ),
                   backgroundColor: Colors.green,
                   onPressed:  widget.onAccept,
                   child: const Icon(Icons.call, color: Colors.white),
                 ),
               )
             ],
           )
         ],
       ),
     ),
   );

  }
}
