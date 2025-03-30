import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../widgets/common_Elevated_Button.dart';
import '../../../widgets/common_appBar.dart';
import '../../../widgets/custom_dialog_box.dart';
import '../../../widgets/custom_textField.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routers/app_routers.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      appBar: CommonAppbar(
        text: "Change Password",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 30,
              ),
              Text("Current Password",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle:
                    const TextStyle(fontSize: 14,
                        fontWeight: bold,
                        color: blackFF101010Color),
                  )),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                textController: currentPasswordController,
                hintText: 'Enter your Current password',
                type: '',
                obsecure: true,
                suffix: true,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  AppRouter.navigatorKey.currentState
                      ?.pushNamed(AppRouter.forgetPasswordScreen);
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text("Forget password",
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: normal,
                            color: purple4C4DDCColor),
                      )),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Text("New Password",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle:
                    const TextStyle(fontSize: 14,
                        fontWeight: bold,
                        color: blackFF101010Color),
                  )),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                textController: confirmPasswordController,
                hintText: 'Enter your new password',
                type: '',
                obsecure: true,
                suffix: true,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Confirm Password",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle:
                    const TextStyle(fontSize: 14,
                        fontWeight: bold,
                        color: blackFF101010Color),
                  )),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                textController: newPasswordController,
                hintText: 'Enter Confirm password',
                type: '',
                obsecure: true,
                suffix: true,
              ),

              SizedBox(
                height: 35,
              ),
              CommonElevatedButton("Reset Password",(){
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogBox(
                        text: "Successful Password Reset!",
                        name:
                        "You can now use your new password to log\nin to your account.",
                        secname: "Done",
                        fun: () {

                          AppRouter.navigatorKey.currentState
                              ?.pop();
                          // AppRouter.navigatorKey.currentState
                          //     ?.pushNamedAndRemoveUntil(AppRouter.logInScreen, (route) => false
                          // );
                        },
                      );
                    });

              }),

            ],),
        ),
      ),
    );
  }
}
