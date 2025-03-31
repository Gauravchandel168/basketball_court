
import 'package:basketball/presentation/screens/otp/widgets/otp_pinfield_widget.dart';
import 'package:flutter/material.dart';
// import 'package:nile/presentation/screens/otp/widgets/otp_pinfield_widget.dart';
import '../../../core/colors/app_colors.dart';
import '../../../widgets/common_appBar.dart';


class OtpScreen extends StatelessWidget {
  final String arguments;

  OtpScreen({
    Key? key, required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      appBar:  CommonAppbar(text: '',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20),
          child: Column(
            children: [
              // OtpScreenWidget(),
              // const SizedBox(
              //   height: 20,
              // ),
              OtpPinFieldWidget(
                  arguments:arguments
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
