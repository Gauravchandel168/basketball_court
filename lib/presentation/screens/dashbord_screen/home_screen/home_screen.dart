import 'package:basketball/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

import 'home_header_widget.dart';
import 'home_list_of_upcoming_game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: purple4C4DDCColor,
        shape: CircleBorder(),
        child: Icon(
          size: 28,
          Icons.add,

          color:  whiteFFFFFFColor,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
            children: [
              SizedBox(height: 20,),
              HomeHeaderWidget(),
              const SizedBox(
                height: 30,
              ),
              HomeListOfUpcomingGame()
            ]),
      )),
    );
  }
}
