import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/colors/app_colors.dart';
import '../core/constants/assets_base_paths.dart';
import '../core/constants/font_weight.dart';
import '../presentation/routers/app_routers.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;

  CommonAppbar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 3,
      leadingWidth: 50,

      primary: true,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: purple4C4DDCColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 4.0,bottom: 7),
        child: InkWell(
          onTap: () {
            AppRouter.navigatorKey.currentState?.pop();
          },
          child: SvgPicture.asset(

           fit: BoxFit.cover,
          "$svgAssetsBasePath/back_arrow.svg"),
        ),
      ),
      title: Text(
        text!,
        style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
          fontSize: 16,
          fontWeight: bold,
          color: blackFF101010Color,
        )),
      ),
      //  actions:  [IconButton(onPressed: function, icon: Icon(Icons.menu,color: Colors.black)),SizedBox(width: 10,)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
