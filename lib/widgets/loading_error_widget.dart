import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors/app_colors.dart';
import '../../core/constants/font_weight.dart';
import '../presentation/routers/app_routers.dart';
// import 'package:payment_foundry/core/colors/app_colors.dart';
// import 'package:payment_foundry/presentation/routers/app_routers.dart';
//
bool _isLoadingVisible = false;

showLoading() async {
  final context = AppRouter.navigatorKey.currentContext;
  if (context == null) {
    return;
  }
  hideBothLoadingAndError();
  _isLoadingVisible = true;
  await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black.withOpacity(0.1),
          child: const Center(
            child: CircularProgressIndicator(
              color: whiteFFFFFFColor,
            ),
          ),
        );
      });
  _isLoadingVisible = false;
}

hideLoading() {
  if (_isLoadingVisible) {
    AppRouter.navigatorKey.currentState?.pop();
  }
  _isLoadingVisible = false;
}

showError(String message) {
  final context = AppRouter.navigatorKey.currentContext;
  if (context == null) {
    return;
  }
  hideBothLoadingAndError();

  var snackBar = SnackBar(
    backgroundColor: purple4C4DDCColor,
    content: Text(message,style:
    GoogleFonts.poppins(
      textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: medium,
          fontSize: 18,

      ),
    ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

hideError() {
  final context = AppRouter.navigatorKey.currentContext;
  if (context == null) {
    return;
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}

hideBothLoadingAndError() {
  hideLoading();
  hideError();
}
