import 'package:basketball/logic/location_cubit.dart';
import 'package:basketball/presentation/screens/dashbord_screen/profile/profile_screen.dart';
import 'package:basketball/presentation/screens/dashbord_screen/up_coming_games/upcoming_games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_base_paths.dart';
import '../../../core/constants/font_weight.dart';
import '../../../logic/navigation/navigation_cubit.dart';
import '../home_detail_screen/home_detail.dart';
import '../login_Screen/login_screen.dart';
import '../signUp_screen/signUp_screen.dart';
import 'home_screen/home_header_widget.dart';
import 'home_screen/home_header_widget.dart';
import 'home_screen/home_screen.dart';
import 'my_games_screen/my_games_screen.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  List<bool> selectedValue = [true, false, false, false];
  List<Widget> widgetList = [
    BlocProvider(
      create: (context) => LocationCubit(),
      child: HomeScreen(),
    ),
    UpcomingGamesScreen(),
    MyGamesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = context
        .watch<NavigationCubit>()
        .state;
    return WillPopScope(
      onWillPop: () async =>
      await false,
      child: Scaffold(
        // backgroundColor: Colors.transparent,

        body: SafeArea(
          bottom: false,
          child: Expanded(child: widgetList[state]),
        ),

        bottomNavigationBar: Container(
          //  height: 70,
          child: BottomNavigationBar(

            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontWeight: medium,
                color: purple4C4DDCColor,
                fontSize: 15,
              ),
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontWeight: medium,
                color: black878787Color,
                fontSize: 15,
              ),
            ),
            elevation: 5,
            backgroundColor: whiteFFFFFFColor,
            selectedItemColor: purple4C4DDCColor,
            unselectedItemColor: black878787Color,
            showUnselectedLabels: true,
            currentIndex: state,
            onTap: (value) {
              context.read<NavigationCubit>().changeIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon:
                  SvgPicture.asset(
                    "$svgAssetsBasePath/home.svg",
                    color: state == 0
                        ? purple4C4DDCColor
                        : black878787Color,
                  ),

                  label: "Home"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "$svgAssetsBasePath/users.svg",
                    color: state == 1
                        ? purple4C4DDCColor
                        : black878787Color,
                  ),
                  label: "Upcoming Games"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "$svgAssetsBasePath/message.svg",
                    color: state == 2
                        ? purple4C4DDCColor
                        : black878787Color,
                  ),
                  label: "My Games"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "$svgAssetsBasePath/profile.svg",
                    color: state == 3
                        ? purple4C4DDCColor
                        : black878787Color,
                  ),
                  label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }

}