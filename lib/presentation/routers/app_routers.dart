import 'package:basketball/logic/video_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/respositories/http_repository/auth_repository.dart';
import '../../logic/auth_cubit/auth_token_store_cubit.dart';
import '../../logic/auth_cubit/sign_in_cubit/sign_in_cubit.dart';
import '../../logic/auth_cubit/sign_up_cubit/sign_up_cubit.dart';
import '../../logic/call_cubit.dart';
import '../../logic/internet/internet_cubit.dart';
import '../screens/change_password_screen/change_password_screen.dart';
import '../screens/dashbord_screen/dash_board_screen.dart';
import '../screens/forget_password_screen/forget_password-screen.dart';
import '../screens/home_detail_screen/home_detail.dart';
import '../screens/login_Screen/login_screen.dart';
import '../screens/new_password_screen/new_password_screen.dart';
import '../screens/new_app/new_app.dart';

import '../screens/otp/otpScreen.dart';
import '../screens/signUp_screen/signUp_screen.dart';
import '../screens/video_call/video_call.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String signUp = "/";

  static const String logInScreen = "/logInScreen";

  static const String dashBoardScreen = "/dashBoardScreen";

  static const String intro = "/intro";

  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String newPasswordScreen = "/newPasswordScreen";
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String otpScreen = "/otpScreen";
  static const String homeDetailScreen = "/homeDetailScreen";
  static const String newAppScreen = "/newAppScreen";
  
  /// video screen for testing 
  static const String videoCallScreen = "/videoCallScreen";


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


    /// video screen for testing
      case videoCallScreen:
        return _videoCallScreen(settings.arguments as String);
        
        
        
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
    return MaterialPageRoute(builder: (context) => BlocProvider(
  create: (context) => SignInCubit(
      context.read<InternetCubit>(),
      context.read<AuthRepository>(),
      context.read<AuthTokenStoreCubit>()
  ),
  child: LoginScreen(),
));
  }

  static _signUp() {
    return MaterialPageRoute(builder: (context) => BlocProvider(
  create: (context) => SignUpCubit(
      context.read<InternetCubit>(), context.read<AuthRepository>()
  ),
  child: SignupScreen(),
));
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



  /// video screen for testing

  static _videoCallScreen(String channelName) {
    return MaterialPageRoute(builder: (context) => BlocProvider(
  create: (context) => VideoCubit(),
  child: VideoCallScreen(channelName:channelName),
));
  }
}
