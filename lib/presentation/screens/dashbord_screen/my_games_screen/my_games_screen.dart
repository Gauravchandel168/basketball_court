import 'package:basketball/core/colors/app_colors.dart';
import 'package:basketball/core/constants/assets_base_paths.dart';
import 'package:basketball/presentation/screens/dashbord_screen/my_games_screen/widgets/my_games_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/font_weight.dart';

class MyGamesScreen extends StatelessWidget {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Games",
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        color: blackFF101010Color,
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    height: 40,
                    "$svgAssetsBasePath/plus_button.svg",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyGameList(),
            ],
          ),
        ),
      ),
    );
  }
}
