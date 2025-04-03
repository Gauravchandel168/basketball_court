import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors/app_colors.dart';
import '../../core/constants/font_weight.dart';
import '../core/constants/assets_base_paths.dart';
import 'button_widget.dart';
import 'common_Elevated_Button.dart';

class DialogBox extends StatelessWidget {
  final String text;
  final String? name;
  final String secname;
  final Function() fun;

  const DialogBox(
      {Key? key,
        required this.text,
        required this.name,
        required this.secname,
        required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "$pngAssetsBasePath/check.png",
                )),
          ),
          SizedBox(
            height: 10,
          ),

          Text(
            // textAlign: TextAlign.center,
            text,
            style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
                fontWeight: bold,
                color: blackFF101010Color,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            textAlign: TextAlign.center,
            name!,
            style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
                fontWeight: normal,
                color: blackFF101010Color,
                fontSize: 9,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonWidget(
            text: secname,
            //"Login",
            containerColor: purple4C4DDCColor,
            fun: fun,
            width: 110,
            height: 40,
          ),
        ],
      ),
    );
    ;
  }
}




