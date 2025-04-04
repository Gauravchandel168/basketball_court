// import 'package:basketball/core/constants/assets_base_paths.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../core/colors/app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../core/constants/font_weight.dart';
// import '../../../logic/video_cubit.dart';
// import '../../../widgets/common_Elevated_Button.dart';
// import '../../../widgets/custom_textField.dart';
// import '../../routers/app_routers.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool _isChecked = false;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteFFFFFFColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SvgPicture.asset("$svgAssetsBasePath/logo.svg"),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Text("Login",
//                     style: GoogleFonts.plusJakartaSans(
//                       textStyle: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: bold,
//                           color: blackFF101010Color),
//                     )),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text("To use your account, you should log in first.",
//                     style: GoogleFonts.plusJakartaSans(
//                       textStyle: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: normal,
//                           color: black878787Color),
//                     )),
//                 const SizedBox(
//                   height: 35,
//                 ),
//                 Text("Email Address",
//                     style: GoogleFonts.plusJakartaSans(
//                       textStyle: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: bold,
//                           color: blackFF101010Color
//                       ),
//                     )),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomTextField(
//                   textController: emailController,
//                   hintText: 'abc@gmail.com',
//                   type: 'number',
//                   obsecure: false,
//                   suffix: false,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 // Text("Password",
//                 //     style: GoogleFonts.plusJakartaSans(
//                 //       textStyle: const TextStyle(
//                 //           fontSize: 14,
//                 //           fontWeight: bold,
//                 //           color: blackFF101010Color),
//                 //     )),
//                 // const SizedBox(
//                 //   height: 10,
//                 // ),
//                 // CustomTextField(
//                 //   textController: PasswordController,
//                 //   hintText: 'enter your password',
//                 //   type: '',
//                 //   obsecure: true,
//                 //   suffix: true,
//                 // ),
//                 // const SizedBox(
//                 //   height: 20,
//                 // ),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   children: [
//                 //     Row(
//                 //       children: [
//                 //         SizedBox(
//                 //           height: 20,
//                 //           width: 20,
//                 //           child: Checkbox(
//                 //             value: _isChecked,
//                 //             activeColor: purple4C4DDCColor,
//                 //             checkColor: whiteFFFFFFColor,
//                 //             splashRadius: 1,
//                 //             side: const BorderSide(color: greyD6D6D6Color),
//                 //             shape: RoundedRectangleBorder(
//                 //                 side: const BorderSide(color: greyD6D6D6Color),
//                 //                 borderRadius: BorderRadius.circular(5)),
//                 //             onChanged: (bool? value) {
//                 //               setState(() {
//                 //                 _isChecked = value!;
//                 //               });
//                 //             },
//                 //           ),
//                 //         ),
//                 //         const SizedBox(
//                 //           width: 12,
//                 //         ),
//                 //         Text("Remember me",
//                 //             style: GoogleFonts.plusJakartaSans(
//                 //               textStyle: const TextStyle(
//                 //                   fontSize: 12,
//                 //                   fontWeight: normal,
//                 //                   color: blackFF101010Color),
//                 //             )),
//                 //       ],
//                 //     ),
//                 //     //SizedBox(width: 60,),
//                 //     InkWell(
//                 //       onTap: () {
//                 //         AppRouter.navigatorKey.currentState
//                 //             ?.pushNamed(AppRouter.forgetPasswordScreen);
//                 //       },
//                 //       child: Text("Forget password",
//                 //           style: GoogleFonts.plusJakartaSans(
//                 //             textStyle: const TextStyle(
//                 //                 fontSize: 12,
//                 //                 fontWeight: normal,
//                 //                 color: purple4C4DDCColor),
//                 //           )),
//                 //     ),
//                 //   ],
//                 // ),
//                 // const SizedBox(
//                 //   height: 55,
//                 // ),
//                 CommonElevatedButton("Login", () {
//                   int number = int.parse(emailController.text);
//                   context.read<VideoCubit>().setUserId(number);
//
//                   AppRouter.navigatorKey.currentState
//                       ?.pushNamed(AppRouter.videoCallScreen);
//                 }),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Don’t have an account?",
//                         style: GoogleFonts.plusJakartaSans(
//                           textStyle: const TextStyle(
//                               fontSize: 13,
//                               fontWeight: normal,
//                               color: black878787Color),
//                         )),
//                     const SizedBox(
//                       width: 6,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         AppRouter.navigatorKey.currentState
//                             ?.pushNamed(AppRouter.signUp);
//                       },
//                       child: Text("Sign Up",
//                           style: GoogleFonts.plusJakartaSans(
//                             textStyle: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: bold,
//                                 color: purple4C4DDCColor),
//                           )),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../widgets/common_Elevated_Button.dart';
import '../../../widgets/custom_textField.dart';
import '../../routers/app_routers.dart';
import '../video_call/video_call.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _channelController = TextEditingController();


  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agora Video Call")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField(
            //   controller: _channelController,
            //   decoration: InputDecoration(labelText: "Enter Channel Name"),
            // ),
        CustomTextField(
                  textController: _channelController,
                  hintText: "Enter Channel Name",
                  //'abc@gmail.com',
                  type: '',
                  obsecure: false,
                  suffix: false,
                ),
            SizedBox(height: 20),

            CommonElevatedButton("Login", () {
              if (_channelController.text.isNotEmpty) {
                // int number = int.parse(emailController.text);
//                   context.read<VideoCubit>().setUserId(number);
//

                _requestPermissions();
                AppRouter.navigatorKey.currentState
                    ?.pushNamed(AppRouter.videoCallScreen,
                    arguments: _channelController.text
                );

              }
            }),
          ],
        ),
      ),
    );
  }
  Future<void> _requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

}

