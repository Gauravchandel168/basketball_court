import 'package:basketball/presentation/screens/forget_password_screen/widget/agoraTokenmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/font_weight.dart';
import '../../../logic/auth_cubit/get_agora_token_channel_cubit.dart';

import '../../routers/app_routers.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  List<UserData> userData = [
    UserData(
      name: "Saakar",
      phnNumber: "+91  1712700224 |  India, Haryana  ",
      color: Colors.orangeAccent,
    ),
    UserData(
      name: "Amit",
      phnNumber: "+91  1812700527 |  India, Haryana  ",
      color: Colors.lightGreen,
    ),
  ];

  @override
  void initState() {
    super.initState();


    _hitInfoApi();
  }
  _hitInfoApi() {
    context.read<GetAgoraTokenChannelCubit>().getAgoraTokenChannel();
  }
  @override
  Widget build(BuildContext context) {
final state = context.watch<GetAgoraTokenChannelCubit>().state;
  return GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: Scaffold(
      backgroundColor: whiteFFFFFFColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        primary: true,
        actionsPadding: EdgeInsets.zero,
        backgroundColor: green2EC35FColor,
        leading: InkWell(
          onTap: () {
            AppRouter.navigatorKey.currentState?.pop();
            AppRouter.navigatorKey.currentState?.pop();
          },
          child:Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ),
          // SvgPicture.asset(
          //   fit: BoxFit.cover,
          //   "$svgAssetsBasePath/back_arrow.svg",
          // ),
        ),
        title: Text(
          "Call Room",
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: bold,
              color: blackFF101010Color,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              // Text("Email Address",
              //     style: GoogleFonts.plusJakartaSans(
              //       textStyle: const TextStyle(
              //           fontSize: 14,
              //           fontWeight: bold,
              //           color: blackFF101010Color),
              //     )),
              // const SizedBox(
              //   height: 10,
              // ),
              // CustomTextField(
              //   textController: emailController,
              //   hintText: 'abc@gmail.com',
              //   type: 'email',
              //   obsecure: false,
              //   suffix: false,
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              // CommonElevatedButton("Reset Password", () {
              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //         return DialogBox(
              //           text: "Email has been sent!",
              //           name:
              //           "Please check your inbox and click in the\nreceive password reset link.",
              //           secname: "Ok",
              //           fun: () {
              //             AppRouter.navigatorKey.currentState
              //                 ?.pop();
              //             // AppRouter.navigatorKey.currentState
              //             //     ?.pop();
              //             AppRouter.navigatorKey.currentState
              //                 ?.pushNamed(AppRouter.otpScreen,
              //                 arguments: ""
              //             );
              //           },
              //         );
              //       });
              //
              // }),
              // CustomTextField(
              //     textController: emailController,
              //     hintText: 'Search',
              //     type: 'email',
              //     obsecure: false,
              //     suffix: false,
              //   ),
              SearchField(context),
              SizedBox(height: 35),
              _userData(context, state)
              

              // CommonElevatedButton("Call", () {
              //   AppRouter.navigatorKey.currentState
              //       ?.pushNamed(AppRouter.videoCallScreen,
              //       // arguments: _channelController.text.trim()
              //       arguments:"basketball"
              //   );
              //
              // }),

              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("Back to",
              //         style: GoogleFonts.plusJakartaSans(
              //           textStyle: const TextStyle(
              //               fontSize: 13,
              //               fontWeight: normal,
              //               color: black878787Color),
              //         )),
              //     SizedBox(
              //       width: 6,
              //     ),
              //     InkWell(
              //       onTap: () {
              //         AppRouter.navigatorKey.currentState
              //             ?.pushNamedAndRemoveUntil(AppRouter.logInScreen, (route) => false
              //         );
              //       },
              //       child: Text("Login",
              //           style: GoogleFonts.plusJakartaSans(
              //             textStyle: const TextStyle(
              //                 fontSize: 13,
              //                 fontWeight: bold,
              //                 color: purple4C4DDCColor),
              //           )),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    ),
  );
  }
  Widget _userData(BuildContext context, GetAgoraTokenChannelState state, ) {
    if (state is GetAgoraTokenChannelSuccess) {
      return
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _userList(userData[index],state);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: userData.length,
        );
    }
    else if (state is GetAgoraTokenChannelLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: green2EC35FColor,
          ),
        ),
      );
    }
    else if (state is GetAgoraTokenChannelError) {
      return Expanded(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.message,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: green2EC35FColor,
                    fontWeight: medium,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _hitInfoApi();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5.4,
                    fixedSize: const Size(140, 50),
                    backgroundColor: Colors.green, // Background color
                  ),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: green2EC35FColor,
                        fontWeight: medium,
                        fontSize: 20,
                      ),
                    ),
                  ))
            ]),
      );
    } else {
      return SizedBox.fromSize();
    }
  }

  Widget SearchField(BuildContext context) {
    return TextField(
      controller: emailController,
      cursorColor: blackFF101010Color,
      keyboardType: TextInputType.text,
      style: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(fontWeight: normal, fontSize: 14),
      ),
      decoration: InputDecoration(
        hintText: "Search",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintStyle: TextStyle(fontWeight: normal, fontSize: 14),
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(width: 30, color: greyD6D6D6Color),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(width: 30, color: greyD6D6D6Color),
        ),
      ),
    );
  }

  Widget _userList(UserData userData, GetAgoraTokenChannelSuccess state) {
    return Card(
      elevation: 0,

      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          _requestPermissions();
          AppRouter.navigatorKey.currentState?.pushNamed(
            AppRouter.videoCallScreen,
            arguments: AgoraTokenModel(

            appId: "dee7af634433419e96023a393890962c",
              channelId: "dd4f9a6a-e870-4d18-9757-dbc052196c78",
              token: "007eJxTYGB/svm1odG5w4q5cuzzzyn/uP3usKSzm6jcYamu7RJnLtsqMKSkpponppkZm5gYG5sYWqZamhkYGScaWxpbWBpYmhkle+z+nN4QyMjQK7aDlZEBAkF8FYaUFJM0y0SzRN1UC3MDXZMUQwtdS3NTc92UpGQDUyNDS7NkcwsGBgB+NiZe"

            //     appId: state.getAgoraTokenAndChannelModel.appId: ??""
            // channelId: state.getAgoraTokenAndChannelModel.channelId: ??""
            // token: state.getAgoraTokenAndChannelModel.token??""

            )
          );
        },
        leading: CircleAvatar(
          backgroundColor: userData.color ?? greyD6D6D6Color,
          radius: 25,
          child: Icon(Icons.person,
          color: blackFF101010Color,
          ),
        ),
        title: Text(
          userData.name,
          style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
              fontSize: 19,
              fontWeight: extraBold,
              color: blackFF101010Color,
            ),
          ),
        ),
        subtitle: Text(
          userData.phnNumber,
          style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: bold,
              color: black878787Color,
            ),
          ),
        ),
        trailing: Icon(Icons.call, color: green2EC35FColor, size: 30),
      ),
    );
  }
  Future<void> _requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }
}

class UserData {
  final String name;
  final String phnNumber;
  final Color? color;
  UserData({required this.name, required this.phnNumber, required this.color});
}
