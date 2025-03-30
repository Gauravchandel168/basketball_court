import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors/app_colors.dart';
import '../../core/constants/font_weight.dart';
import '../core/constants/assets_base_paths.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;

  final String type;

  final String hintText;
  final bool suffix;
  final obsecure;

  CustomTextField(
      {Key? key,
        required this.textController,
        required this.hintText,
        required this.type,
        required this.suffix,
        this.obsecure})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obSecure;

  @override
  void initState() {
    super.initState();
    obSecure = widget.obsecure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      cursorColor: blackFF101010Color,
      keyboardType: widget.type == "time"
          ? TextInputType.datetime
          : widget.type == "number"
          ? TextInputType.number
          : widget.type == "email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      style: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(
          fontWeight: normal,
          fontSize: 14,
        ),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(

        ),
        hintStyle: TextStyle(
          fontWeight: normal,
          fontSize: 14,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: greyD6D6D6Color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: greyD6D6D6Color,
            )),
        suffixIcon: widget.suffix
            ? InkWell(
            onTap: () {
              setState(() {
                obSecure = !obSecure;
              });
            },
            child: obSecure
                ? Icon(
              size: 20,

              Icons.code_off_sharp,
              color: blackFF101010Color,
            )
            // SvgPicture.asset("$svgAssetsBasePath/eye_off.svg",
            //     fit: BoxFit.scaleDown)
                : Icon(
              Icons.remove_red_eye_sharp,
              size: 20,
              color: blackFF101010Color,
            ))
            : const SizedBox.shrink(),
      ),
      obscureText: obSecure,
    );
  }
}
