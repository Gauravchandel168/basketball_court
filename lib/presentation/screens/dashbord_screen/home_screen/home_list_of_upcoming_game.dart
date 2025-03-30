import 'package:basketball/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/assets_base_paths.dart';
import '../../../../core/constants/font_weight.dart';
import '../../../routers/app_routers.dart';

class HomeListOfUpcomingGame extends StatelessWidget {
  const HomeListOfUpcomingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: 12,
          itemBuilder: (context, index) {
            return InkWell(
              highlightColor:whiteFFFFFFColor ,

              onTap: (){
                AppRouter.navigatorKey.currentState
                    ?.pushNamed(AppRouter.homeDetailScreen,
                );

              },
              child: Card(
                elevation: 2,
                color: whiteFFFFFFColor,

                shape: const OutlineInputBorder(
                    borderSide: BorderSide(color:whiteFFFFFFColor ),
                    borderRadius: BorderRadius.all(Radius.circular(14))),

                  child: Column(
                    children: [

                      Image.asset(
                        width: double.infinity,
                          fit: BoxFit.fill,
                          "$pngAssetsBasePath/Mask_group.png"),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textRow(img:"$svgAssetsBasePath/person_img.svg",color:blackFF101010Color,fontSize:12, text: '3/12'  ),
                            const SizedBox(height: 10,),

                            Text(
                              "Better Gym Basketball court",
                              style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                                color: blackFF101010Color,
                                fontSize: 14,
                                fontWeight: bold
                              ),
                            )),
                            const SizedBox(height: 10,),
                            _textRow(img:"$svgAssetsBasePath/location.svg",color:grey878787Color,fontSize:12,
                                text: 'Wilora NT 0872, Australia'  ),
                            const SizedBox(
                              height: 10,
                            ),

                            _textRow(img:"$svgAssetsBasePath/calendar.svg",color:grey878787Color,fontSize:12,
                                text: '30 Apr, 7:15 PM'  ),
                          ],
                        ),
                      ),



                    ],
                  ),

              ),
            );
          }),
    );
  }


 Widget _textRow({required String img,required String text, required Color color, required double fontSize }){
    return Row(
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(img),
        const SizedBox(width: 10,),
        Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: medium
            ),

          ),
        )
      ],
    );
  }
}
