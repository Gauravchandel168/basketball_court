import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_base_paths.dart';
import '../../../core/constants/font_weight.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../widgets/button_widget.dart';

class DetailScreenBody extends StatefulWidget {
  const DetailScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreenBody> createState() => _DetailScreenBodyState();
}

class _DetailScreenBodyState extends State<DetailScreenBody> {
  late final PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: PageView(

              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              controller: _pageController,
              children: List.generate(
                4,

                    (index) => pageViewScreen(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          dotIndigator(4),
          const SizedBox(
            height: 20,
          ),
          _noOfPlayeRow(
              image: "$svgAssetsBasePath/person_img.svg",
              text:
              // "${widget.games.bookedSlots?.length}/${widget.games.noOfPlayers}",
              "3/12",
              clr: blackFF101010Color),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child:

                Text("Better Gym Basketball court",

                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: bold,
                          color: blackFF101010Color),
                    )),

              ),
              RichText(
                text: TextSpan(
                  text: '\$50', // First part of the text
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: bold,
                        color: purple4C4DDCColor),
                  )                  , // Default style
                  children: <TextSpan>[
                    TextSpan(
                      text: 'p/p', // Second part with different style
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: normal,
                              color: purple4C4DDCColor),
                        )                    ),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          row(
              image: "$svgAssetsBasePath/location.svg",
              text: "Wilora NT 0872, Australia",
              clr: grey878787Color),
          const SizedBox(
            height: 12,
          ),
          row(
              image: "$svgAssetsBasePath/calendar.svg",
              text:
              "30 Apr, 7:15 PM",
              clr: grey878787Color),
          const SizedBox(
            height: 25,
          ),

          Text(
              "Games Rules and Instrutions",
              style: GoogleFonts.plusJakartaSans(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: bold,
                    color: blackFF101010Color),
              )),
          const SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(children: [
                TextSpan(
                  style: TextStyle(color: grey878787Color),
                  text: "Sed ut perspiciatis unde omnis iste natus error sit "
                      "voluptatem accusantium doloremque laudantium, "
                      "totam rem aperiam, eaque ipsa quae ab illo inventore "
                      "veritatis et quasi architecto beatae vitae dicta sunt "
                      ". Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia "
                      "consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt Read More...",

                ),

              ])),

          const SizedBox(
            height: 20,
          ),
          // ButtonWidget(text: 'Book  Spot',
          //   containerColor: purple4C4DDCColor,
          //   fun: () {  },
          //   width: double.infinity,
          //   height: 45,
          // ),

        ],
      ),
    );
  }

  Widget dotIndigator(int length) {
    return Center(
      child: SmoothPageIndicator(
          controller: _pageController, // PageController
          count: length,
          effect: SlideEffect(
              spacing: 8.0,
              radius: 4.0,
              dotWidth: 10.0,
              dotHeight: 10.0,
              dotColor: greyD6D6D6Color,
              activeDotColor: purple4C4DDCColor),
          onDotClicked: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInCubic);
          }),
    );
  }

  Widget pageViewScreen() {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child:  Image.asset(
            width: double.infinity,
            fit: BoxFit.fill,
            "$pngAssetsBasePath/Image.png"),
        // CachedNetworkImage(
        //     imageUrl: "$pngAssetsBasePath/Image.png",
        //     fit: BoxFit.cover,
        //     placeholder: _loader,
        //     errorWidget: _error)
    );
  }

  Widget row({required String image, required String text, required Color clr}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          image,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
                fontWeight: medium,
                color: clr,
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _noOfPlayeRow({required String image, required String text, required Color clr}) {
    return Container(
     width: 95,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      decoration: BoxDecoration(
        color: whiteGreyF5F5FFB2Color.withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            image,
            height: 20,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontWeight: medium,
                  color: clr,
                  fontSize: 14,
                ),
              ),
            ),

        ],
      ),
    );
  }

  Widget _loader(BuildContext context, String url) {
    return  Center(
      child: Container(
        color: Colors.grey.withOpacity(0.3),
      ),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return  Center(child: Container(
      color: Colors.grey.withOpacity(0.3),
    ));
  }
}
