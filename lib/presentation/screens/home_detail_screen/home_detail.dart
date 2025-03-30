import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/common_appBar.dart';
import '../../../widgets/custom_dialog_box.dart';
import '../../routers/app_routers.dart';
import 'home_screen_body.dart';

class HomeDetailScreen extends StatelessWidget {
  const HomeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
bottomNavigationBar: SizedBox(height: 45,),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20),
        child: ButtonWidget(
          text: 'Book  Spot',
          containerColor: purple4C4DDCColor,
          fun: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogBox(
                    text: "Congratulations!",
                    name:
                    "Game booked successfully.",
                    secname: "Ok",
                    fun: () {
                      AppRouter.navigatorKey.currentState
                          ?.pop();
                      // AppRouter.navigatorKey.currentState
                      //     ?.pop();
                      AppRouter.navigatorKey.currentState
                          ?.pushNamed(AppRouter.dashBoardScreen,

                      );
                    },
                  );
                });
          },
          width: double.infinity,
          height: 55,
        ),
      ),
      appBar: CommonAppbar(
        text: "Detail",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            DetailScreenBody()
          ],
        )),
      ),
    );
  }
}
