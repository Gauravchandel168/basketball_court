import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/font_weight.dart';
import '../../../widgets/common_Elevated_Button.dart';
import '../../../widgets/common_appBar.dart';
import '../../../widgets/custom_dialog_box.dart';
import '../../../widgets/custom_textField.dart';
import '../../routers/app_routers.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      appBar: CommonAppbar(
        text: "Forgot Password",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Text("Email Address",
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: bold,
                            color: blackFF101010Color),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    textController: emailController,
                    hintText: 'abc@gmail.com',
                    type: 'email',
                    obsecure: false,
                    suffix: false,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CommonElevatedButton("Reset Password", () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogBox(
                            text: "Email has been sent!",
                            name:
                            "Please check your inbox and click in the\nreceive password reset link.",
                            secname: "Ok",
                            fun: () {
                              AppRouter.navigatorKey.currentState
                                  ?.pop();
                              // AppRouter.navigatorKey.currentState
                              //     ?.pop();
                              AppRouter.navigatorKey.currentState
                                  ?.pushNamed(AppRouter.otpScreen,
                                  arguments: ""
                              );
                            },
                          );
                        });

                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Back to",
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: normal,
                                color: black878787Color),
                          )),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () {
                          AppRouter.navigatorKey.currentState
                              ?.pushNamedAndRemoveUntil(AppRouter.logInScreen, (route) => false
                          );
                        },
                        child: Text("Login",
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: bold,
                                  color: purple4C4DDCColor),
                            )),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
