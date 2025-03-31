import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/font_weight.dart';
import '../../../../widgets/button_widget.dart';
import '../../../routers/app_routers.dart';

class OtpPinFieldWidget extends StatefulWidget {
  final String arguments;
  const OtpPinFieldWidget({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<OtpPinFieldWidget> createState() => OtpPinFieldWidgetState();
}

class OtpPinFieldWidgetState extends State<OtpPinFieldWidget> {
  late FocusNode _focusNode;
  final TextEditingController _controller = TextEditingController();

  String getOtp() => _controller.text;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(
      canRequestFocus: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),

        Text("OTP verification",
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontWeight: normal,
                color: blackFF101010Color,
                fontSize: 15,
              ),
            )),
        SizedBox(
          height: 8,
        ),
        Text("Enter the verification code we just sent on your\nemail address",
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontWeight: normal,
                color: black878787Color,
                fontSize: 11,
              ),
            )),
        const SizedBox(
          height: 35,
        ),

        Center(
          child: Pinput(
            length: 4,
            focusNode: _focusNode,
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: GoogleFonts.spaceGrotesk(
                  color: blackFF101010Color, fontWeight: bold, fontSize: 14),
              decoration: BoxDecoration(
                border: Border.all(color: greyWhiteE7DFDFColor),
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            controller: _controller,

            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            // onCompleted: (pin) => print(pin),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        // BlocListener<ForgetRequestCubit, ForgetRequestState>(
        //   listener: (context, state) {
        //     if (state is ForgetRequestLoading) {
        //       easyLoadingShowProgress(status: "Resend...");
        //     } else if (state is ForgetRequestSuccess) {
        //       easyLoadingDismiss(withDismiss: true);
        //     } else if (state is ForgetRequestError) {
        //       easyLoadingShowError(state.message);
        //     }
        //   },
        //   child: Align(
        //     alignment: Alignment.topLeft,
        //     child: InkWell(
        //       onTap: () {
        //         context
        //             .read<ForgetRequestCubit>()
        //             .forgetPassword(email: widget.arguments.trim());
        //       },
        //       child: Text(
        //         "Resend",
        //         style: GoogleFonts.plusJakartaSans(
        //             textStyle: TextStyle(
        //                 color: lightBlue4C4DDCColor,
        //                 fontSize: 12,
        //                 fontWeight: medium)),
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // BlocListener<OtpReqCubit, OtpReqState>(
        //   listener: (context, state) {
        //     if (state is OtpReqLoading) {
        //       easyLoadingShowProgress(status: "Confirm...");
        //     } else if (state is OtpReqSuccess) {
        //       easyLoadingDismiss(withDismiss: true);
        //       AppRouter.navigatorKey.currentState
        //           ?.pushNamed(AppRouter.newPasswordScreen,
        //       arguments: widget.arguments,
        //       );
        //     } else if (state is OtpReqError) {
        //       easyLoadingShowError(state.message);
        //     }
        //   },
        //    ButtonWidget(
        //     text: "Confirm",
        //     containerColor: green95BF47Color,
        //     fun: () {
        //       // context.read<OtpReqCubit>().otpReq(
        //       //     email: widget.arguments,
        //       //     otp: _controller.text);
        //     },
        //     width: double.infinity,
        //     height: 45,
        //   ),
        // )

        ButtonWidget(
          text: "Confirm",
          containerColor: purple4C4DDCColor,
          fun: () {
            // context.read<OtpReqCubit>().otpReq(
            //     email: widget.arguments,
            //     otp: _controller.text);
            AppRouter.navigatorKey.currentState?.pushNamed(
              AppRouter.newPasswordScreen,
             // arguments: widget.arguments,
            );
          },
          width: double.infinity,
          height: 45,
        ),
      ],
    );
  }
}
