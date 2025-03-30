import 'package:basketball/core/colors/app_colors.dart';
import 'package:basketball/presentation/screens/dashbord_screen/up_coming_games/widgets/upcoming_games_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/font_weight.dart';
import '../home_screen/home_header_widget.dart';
import '../home_screen/home_list_of_upcoming_game.dart';


class UpcomingGamesScreen extends StatelessWidget {
  const UpcomingGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,

      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text(
                      "Upcoming Games",
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            color: blackFF101010Color,
                            fontSize: 20,
                            fontWeight: bold
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  UpcomingGameList()
                ]),
          )),
    );
  }
}
