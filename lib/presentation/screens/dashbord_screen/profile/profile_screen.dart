import 'package:basketball/presentation/screens/dashbord_screen/profile/widgets/profile_body_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/assets_base_paths.dart';
import '../../../../core/constants/font_weight.dart';
import '../../../../widgets/common_Elevated_Button.dart';
import '../../../../widgets/custom_dialog_box.dart';
import '../../../../widgets/custom_textField.dart';
import '../../../../widgets/upload_photo_widget.dart';
import '../../../routers/app_routers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            child: ProfileBodyScreen()
          ),
        ),
      ),
    );
  }


}
