import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/constants/font_weight.dart';
import '../../../../core/constants/assets_base_paths.dart';
import '../../../../logic/location_cubit.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  @override
  void initState() {
    _hitApi();
    super.initState();
  }
_hitApi(){
  context.read<LocationCubit>().fetchLocation();
  }
  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationCubit>().state;
    if (locationState is LocationSuccess) {
      print("locations");
      print(locationState.address);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Current location",
            maxLines: 1,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: medium,
                color: black878787Color,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset("$svgAssetsBasePath/map_pin.svg"),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  locationState.address,
                 // "London, United Kingdom",
                  maxLines: 7,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: medium,
                      color: blackFF101010Color,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
        ],
      );
    } else if (locationState is LocationLoading) {
      return CircularProgressIndicator(color: purple4C4DDCColor);
    } else if (locationState is LocationError) {
      return Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locationState.message,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    color: purple4C4DDCColor,
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
                    _hitApi();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5.4,
                    fixedSize: const Size(140, 50),
                    backgroundColor: purple4C4DDCColor, // Background color
                  ),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: whiteFFFFFFColor,
                        fontWeight: medium,
                        fontSize: 20,
                      ),
                    ),
                  ))
            ]),
      );

    } else {
      return SizedBox.shrink();
    }
  }
}
