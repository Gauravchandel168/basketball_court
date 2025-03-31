import 'package:basketball/presentation/routers/app_routers.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_base_paths.dart';
import '../../../widgets/common_Elevated_Button.dart';

class NewAppScreen extends StatelessWidget {
  const NewAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFFFFFFColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: whiteFFFFFFColor,
        leading: Icon(
          Icons.arrow_back,
        ),
        actions: [
          Icon(
            Icons.menu,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  "Contract Existence and Formation",
                  style: TextStyle(
                      fontSize: 16,
                      // fontWeight:semiBold,
                      color: blue242B42Color),
                ),
                Icon(
                  Icons.pause_circle_outline_outlined,
                )
              ]),

              //  Read the passage and answer the question
              Expanded(
                child: Container(
                  //alignment: Alignment.left,
                  padding: const EdgeInsets.only(left: 10.0, right: 10,),
                  decoration: BoxDecoration(
                      color: greyF6F7FAColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Read the passage and answer the question",
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight:semiBold,
                            color: blue242B42Color,
                          ),
                        ),
                        Text(
                          "A company director instructs a broker to sell a piece of company real estate. "
                              "The broker contacts a potential buyer. The director tells the broker to make an "
                              "offer on these terms: 'The property will be sold to you for £500,000 and the "
                              "paperwork will be completed within 14 days of receiving payment. You have 30 days "
                              "from today to think about this offer.' The broker conveys this offer to the potential buyer. Two weeks later, "
                              "the director informs the broker that he no longer wants to sell the property.",
                          style: TextStyle(
                            fontSize: 13,
                            // fontWeight:semiBold,
                            color: blue242B42Color,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "In this scenario, has the company director "
                              "successfully revoked the offer to sell the property?",
                          style: TextStyle(
                            fontSize: 16,

                            // fontWeight:semiBold,
                            color: blue242B42Color,
                          ),
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.feedback_outlined,
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return dialog();
                                    });
                              },
                              child: Text(
                                "Read the feedback",
                                style: TextStyle(
                                  fontSize: 14,

                                  // fontWeight:semiBold,
                                  color: blue0E4347Color,
                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        CommonElevatedButton("Reset Password", () {}),
                      ]),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  dialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: (){
                  AppRouter.navigatorKey.currentState?.pop();
                },
                child: Icon(Icons.backspace_outlined)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Solution",
            style: TextStyle(
                fontSize: 16,
                // fontWeight:semiBold,
                color: blue242B42Color),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "This is the correct answer. "
                "The manager’s stipulation that they need to "
                "receive order confirmation by a specific time implies "
                "that the postal rule (which states acceptance occurs when "
                "the letter of acceptance is posted) does not apply in this "
                "case.  This is false. Despite the letter being sent, "
                "the manager’s stipulation for a deadline indirectly rules out the"
                " postal rule.  This is false. The postal rule can apply for "
                "any form of communication, provided the conditions are fulfilled."
                "  This is false. The type of transaction does not affect the "
                "applicability of the postal rule.  This is false. The postal rule can apply "
                "regardless of the participating entities, provided the conditions are fulfilled.",
            style: TextStyle(
                fontSize: 16,
                // fontWeight:semiBold,
                color: blue242B42Color),
          ),
        ],
      ),
    );
  }
}