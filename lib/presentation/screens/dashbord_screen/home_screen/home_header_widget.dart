import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/constants/font_weight.dart';
import '../../../../core/constants/assets_base_paths.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Current location",
          maxLines: 1,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
                fontSize: 14, fontWeight: medium, color: black878787Color),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SvgPicture.asset(
              "$svgAssetsBasePath/map_pin.svg",
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "London, United Kingdom",
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontWeight: medium,
                  color: blackFF101010Color,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),

            Icon(Icons.keyboard_arrow_down_rounded),

          ],
        ),


      ],
    );
  }
}
