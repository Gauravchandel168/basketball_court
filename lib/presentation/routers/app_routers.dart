import 'package:flutter/material.dart';

import '../screens/change_password_screen/change_password_screen.dart';
import '../screens/dashbord_screen/dash_board_screen.dart';
import '../screens/dashbord_screen/home_screen/home_screen.dart';
import '../screens/forget_password_screen/forget_password-screen.dart';
import '../screens/home_detail_screen/home_detail.dart';
import '../screens/login_Screen/login_screen.dart';
import '../screens/new_password_screen/new_password_screen.dart';
import '../screens/new_app/new_app.dart';

import '../screens/otp/otpScreen.dart';
import '../screens/signUp_screen/signUp_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String dashBoardScreen = "/";

  static const String logInScreen = "/login";
  static const String intro = "/intro";

  static const String signUp = "/signUp";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String newPasswordScreen = "/newPasswordScreen";
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String otpScreen = "/otpScreen";
  static const String homeDetailScreen = "/homeDetailScreen";
  static const String newAppScreen = "/newAppScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashBoardScreen:
        return _dashBoardScreen();
      case logInScreen:
        return _logInScreen();
      case signUp:
        return _signUp();
      case forgetPasswordScreen:
        return _forgetPasswordScreen();
      case newPasswordScreen:
        return _newPasswordScreen();
        case changePasswordScreen:
        return _changePasswordScreen();
        case otpScreen:
        return _otpScreen();
        case homeDetailScreen:
        return _homeDetailScreen();
      case newAppScreen:
        return _newAppScreen();
      default:
        throw Exception("Route was not Found");
    }
  }

  static _dashBoardScreen() {
    return MaterialPageRoute(
      builder: (context) => DashBoardScreen(),
    //  builder: (context) => HomeScreen(),
    );
  }

  static _logInScreen() {
    return MaterialPageRoute(builder: (context) => LoginScreen());
  }

  static _signUp() {
    return MaterialPageRoute(builder: (context) => SignupScreen());
  }

  static _forgetPasswordScreen() {
    return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
  }

  static _newPasswordScreen() {
    return MaterialPageRoute(builder: (context) => NewPasswordScreen());
  }
  static _changePasswordScreen() {
    return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
  }
  static _otpScreen() {
    return MaterialPageRoute(builder: (context) => OtpScreen(arguments: '',));
  }
  static _homeDetailScreen() {
    return MaterialPageRoute(builder: (context) => HomeDetailScreen());
  }

  static _newAppScreen() {
    return MaterialPageRoute(builder: (context) => NewAppScreen());
  }
}
