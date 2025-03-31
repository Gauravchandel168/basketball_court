import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/font_weight.dart';


class OtpScreenWidget extends StatelessWidget {

  const OtpScreenWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Text("Enter OTP",
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: semiBold,
                    color: blackFF101010Color))),
        SizedBox(
          height: 10,
        ),
        Text(
          "An 6 digit code has been sent to 9671456900",
          style: GoogleFonts.inter(
              color: grey878787Color, fontWeight: normal, fontSize: 12),
        ),
      ],
    );
  }
}
