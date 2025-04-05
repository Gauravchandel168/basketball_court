import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_base_paths.dart';
import '../../../core/constants/font_weight.dart';
import '../../../logic/auth_cubit/sign_up_cubit/sign_up_cubit.dart';
import '../../../logic/upload_image_cubit/upload_image_cubit.dart';
import '../../../widgets/common_Elevated_Button.dart';
import '../../../widgets/custom_textField.dart';
import '../../../widgets/loading_error_widget.dart';
import '../../routers/app_routers.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isChecked = false;
  TextEditingController firstNameontroller = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset("$svgAssetsBasePath/logo.svg"),
                const SizedBox(
                  height: 30,
                ),
            
                Text("Sign Up",
                    style: GoogleFonts.plusJakartaSans(
                      textStyle:
                      const TextStyle(fontSize: 14,
                          fontWeight: bold,
                          color: blackFF101010Color),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Text("Enter below details to sign up",
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: normal,
                          color: black878787Color),
                    )),
                const SizedBox(
                  height: 30,
                ),
                _textRow(),
                const SizedBox(
                  height: 10,
                ),
            _textFieldRw(
                         textController: firstNameontroller, hintText: 'Adam'),
                // Row(
                //   children: [
                //     Expanded(
                //       child: _textFieldRw(
                //           textController: firstNameontroller, hintText: 'Adam'),
                //     ),
                //     const SizedBox(
                //       width: 15,
                //     ),
                //     Expanded(
                //       child: _textFieldRw(
                //           textController: lastnameController, hintText: 'Smith'),
                //     ),
                //   ],
                //
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text("Email Address",
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
                  textController: emailController,
                  hintText: 'abc@gmail.com',
                  type: 'email',
                  obsecure: false,
                  suffix: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Age",
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
                  textController: phoneNumberController,
                  hintText: 'Enter your age',
                  type: 'number',
                  obsecure: false,
                  suffix: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Password",
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
                  textController: passwordController,
                  hintText: 'Enter your password',
                  type: '',
                  obsecure: true,
                  suffix: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        value: _isChecked,
                        activeColor: purple4C4DDCColor,
                        checkColor: whiteFFFFFFColor,
                        splashRadius: 1,
                        side: const BorderSide(color: greyD6D6D6Color),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: greyD6D6D6Color),
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "I agree to the terms and conditions",
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: normal,
                              color: blackFF101010Color
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 55,
                ),
                // CommonElevatedButton("Login", () {
                //
                // }),
                BlocListener<SignUpCubit, SignUpState>(
                  listener: (context, state) {

                    if (state is SignUpLoading) {
                      showLoading();
                    } else if (state is SignUpError) {
                      showError(state.message);
                    } else if (state is SignUpSuccess) {
                      hideBothLoadingAndError();
                    //   AppRouter.navigatorKey.currentState?.pop();
                      AppRouter.navigatorKey.currentState
                          ?.pushNamed(AppRouter.logInScreen);
                    }

                  },
                  child:
                  CommonElevatedButton("Sign Up", () {
                    context.read<SignUpCubit>().signUpMethod(
                        firstNameontroller.text,
                        emailController.text,
                        passwordController.text,
                       // confirmPaswordController.text,
                        num.parse(phoneNumberController.text),
                        context
                            .read<UploadImageCubit>()
                            .state
                            .localImage ??
                            "");
                  }),

                ),

                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: GoogleFonts.plusJakartaSans(
                          textStyle:
                          const TextStyle(fontSize: 13,
                              fontWeight: normal,
                              color: black878787Color),
                        )),
                    const SizedBox(
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
                            textStyle:
                            const TextStyle(fontSize: 13,
                                fontWeight: bold,
                                color: purple4C4DDCColor),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _textRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("First Name",
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: bold,
                  color: blackFF101010Color),
            )),
        // const SizedBox(
        //   width: 15,
        // ),
        // Expanded(
        //   child: Text("Last Name",
        //       style: GoogleFonts.plusJakartaSans(
        //         textStyle: const TextStyle(
        //
        //             fontSize: 14,
        //             fontWeight: bold,
        //             color: blackFF101010Color
        //         ),
        //       )),
        // )
      ],
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
