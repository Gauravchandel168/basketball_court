import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/font_weight.dart';

class CommonElevatedButton extends StatelessWidget {
  String text;
  Function() onTap;

  CommonElevatedButton(this.text, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20.0, right: 20,top: 15,bottom: 15),
        decoration: BoxDecoration(
            color: purple4C4DDCColor,
            borderRadius:
            BorderRadius.only(topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)
            )),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: bold,
                  color: whiteFFFFFFColor,
                )),
          ),
        ),
      ),
    );
  }
}
