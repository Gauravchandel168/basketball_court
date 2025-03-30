import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../widgets/common_Elevated_Button.dart';
import '../../../widgets/common_appBar.dart';
import '../../../widgets/custom_dialog_box.dart';
import '../../../widgets/custom_textField.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routers/app_routers.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      appBar: CommonAppbar(
        text: "",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20),
          child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Create New Password",
                style: GoogleFonts.plusJakartaSans(
                  textStyle:
                  const TextStyle(fontSize: 14,
                      fontWeight: bold,
                      color: blackFF101010Color),
                )),
            const SizedBox(
              height: 5,
            ),
            Text("Your new password must be different from previous\nused passwords.",
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: normal,
                      color: black878787Color),
                )),
            const SizedBox(
              height: 30,
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

                        // AppRouter.navigatorKey.currentState
                        //     ?.pop();
                        AppRouter.navigatorKey.currentState
                            ?.pushNamedAndRemoveUntil(AppRouter.logInScreen, (route) => false
                        );
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
