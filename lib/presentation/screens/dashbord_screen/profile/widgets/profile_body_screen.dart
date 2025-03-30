import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/constants/assets_base_paths.dart';
import '../../../../../core/constants/font_weight.dart';
import '../../../../../widgets/common_Elevated_Button.dart';
import '../../../../../widgets/custom_dialog_box.dart';
import '../../../../../widgets/custom_textField.dart';
import '../../../../../widgets/upload_photo_widget.dart';
import '../../../../routers/app_routers.dart';

class ProfileBodyScreen extends StatefulWidget {
  const ProfileBodyScreen({super.key});

  @override
  State<ProfileBodyScreen> createState() => _ProfileBodyScreenState();
}


class _ProfileBodyScreenState extends State<ProfileBodyScreen> {
  TextEditingController firstNameontroller = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? imgPath = "";


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Text(
            "My Profile",
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: bold,
                color: blackFF101010Color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        UploadPhotoWidget(
          //imgPath: state.getProfileModel.user?.profileURL ?? "",
          imgPath: imgPath ?? "",
          setImgPath: (String value) {
            // context.read<>()
          },
        ),
        const SizedBox(height: 60),
        _textRow(),
        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: _textFieldRw(
                textController: firstNameontroller,
                hintText: 'Adam',
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _textFieldRw(
                textController: lastnameController,
                hintText: 'Smith',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Email Address",
          style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: bold,
              color: blackFF101010Color,
            ),
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          textController: emailController,
          hintText: 'abc@gmail.com',
          type: 'email',
          obsecure: false,
          suffix: false,
        ),
        const SizedBox(height: 10),
        Text(
          "Phone Number",
          style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: bold,
              color: blackFF101010Color,
            ),
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          textController: emailController,
          hintText: 'Enter your phone number',
          type: 'number',
          obsecure: false,
          suffix: false,
        ),
        const SizedBox(height: 10),

        const SizedBox(height: 40),

        CommonElevatedButton("Update", () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                text: "Success!",
                name: "Your information has been updated\nsuccessfully.",
                secname: "Ok",
                fun: () {
                  AppRouter.navigatorKey.currentState?.pop();

                  // AppRouter.navigatorKey.currentState
                  //     ?.pushNamed(AppRouter.dashBoardScreen,
                  // );
                },
              );
            },
          );
        }),
        const SizedBox(height: 40),
        _iconRow(
          img: "$svgAssetsBasePath/lock_icon.svg",
          color: green2EC35FColor,
          text: "Change Password",
          onTap: () {
            AppRouter.navigatorKey.currentState
                ?.pushNamed(AppRouter.changePasswordScreen,
            );
          },
        ),
        const SizedBox(height: 25),
        _iconRow(
          img: "$svgAssetsBasePath/logout_icon.svg",
          color: redE74C3CColor,
          text: "Logout",
          onTap: () {  },
        ),
      ],
    );
  }
  _textRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text("First Name",
              style: GoogleFonts.plusJakartaSans(
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: bold,
                    color: blackFF101010Color),
              )),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text("Last Name",
              style: GoogleFonts.plusJakartaSans(
                textStyle: const TextStyle(

                    fontSize: 14,
                    fontWeight: bold,
                    color: blackFF101010Color
                ),
              )),
        )
      ],
    );
  }
  Widget _iconRow({
    required String img,
    required String text,
    required Color color,
    required Function() onTap,

  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(img),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  _textFieldRw(
      {required TextEditingController textController, required String hintText}) {
    return TextField(
      controller: textController,
      cursorColor: blackFF101010Color,
      keyboardType: TextInputType.text,
      style: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(
          fontWeight: normal,
          fontSize: 14,
        ),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(

        ),
        hintStyle: const TextStyle(
          fontWeight: normal,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: greyD6D6D6Color,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: greyD6D6D6Color,
            )),

      ),
    );
  }
}
