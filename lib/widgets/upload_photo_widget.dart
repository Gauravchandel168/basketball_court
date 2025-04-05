import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/colors/app_colors.dart';
import '../../core/constants/font_weight.dart';
import '../core/constants/assets_base_paths.dart';
import '../logic/upload_image_cubit/upload_image_cubit.dart';
import '../presentation/routers/app_routers.dart';

class UploadPhotoWidget extends StatefulWidget {
  const UploadPhotoWidget({
    Key? key,
    required this.imgPath,
    required this.setImgPath,
  }) : super(key: key);
  // final String? initialImagePath;
  final String imgPath;
  final Function setImgPath;

  @override
  State<UploadPhotoWidget> createState() => UploadPhotoWidgetState();
}

class UploadPhotoWidgetState extends State<UploadPhotoWidget> {
  String? imagePath;

  String? get imageAdd => imagePath;
  // String? intImage;
  @override
  void initState() {
    super.initState();

    context.read<UploadImageCubit>().init(widget.imgPath);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UploadImageCubit>().state;

    return !(state.hasLocalImage)
        ? InkWell(
        onTap: () {
          modelSheet();
        },
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(80)),
            child: Image.network(
              fit: BoxFit.fill,
              height: 100,
              width: 100,
              state.networkImage ?? "",
              errorBuilder: (context, error, stackTrace) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: whiteF2F2F2Color,
                      ),
                    ),
                    const Icon(
                        size: 70,
                        color: Colors.black38,
                        Icons.person_rounded),
                    Positioned(
                        top: 64,
                        left: 30,
                        right: -52,
                        child: SvgPicture.asset(
                            '$svgAssetsBasePath/camera.svg')
                    ),
                    const Icon(
                        size: 70,
                        color: Colors.black38,
                        Icons.person_rounded)
                  ],
                );
              },
            ),
            // child: CachedNetworkImage(
            //   imageUrl: state.networkImage ?? "",
            //   errorListener: (value) {
            //     print(value);
            //   },
            //   imageBuilder: (context, imageProvider) {
            //     return Container();
            //   },
            //   // imageBuilder: (context, imageProvider) => Container(
            //   //   decoration: BoxDecoration(
            //   //     image: DecorationImage(
            //   //       image: imageProvider,
            //   //       fit: BoxFit.fill,
            //   //
            //   //       // colorFilter:
            //   //       //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
            //   //     ),
            //   //   ),
            //   // ),
            //   placeholder: _loader,
            //   errorWidget: _error,
            // ),
          ),
          // Image.network(
          //   fit: BoxFit.fill,
          //   height: 100,
          //   width: 100,
          //   state.networkImage ?? "",
          //   errorBuilder: (context, error, stackTrace) {
          //     return const
          //     Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         Center(
          //           child: CircleAvatar(
          //             radius: 50,
          //             backgroundColor: whiteF2F2F2Color,
          //           ),
          //         ),
          //         Icon(
          //             size: 70,
          //             color: Colors.black38,
          //             Icons.person_rounded),
          //         // SvgPicture.asset(
          //         //     '$svgAssetsBasePath/camera_icon.svg')
          //
          //         Icon(
          //             size: 70,
          //             color: Colors.black38,
          //             Icons.person_rounded)
          //       ],
          //     );
          //   },
          // ),
        ))
        : InkWell(
      onTap: () {
        modelSheet();
        context.read<UploadImageCubit>().delete();
      },
      child: Center(
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.all(Radius.circular(60)),
            child: Image.file(
              File(state.localImage ?? ""),
              fit: BoxFit.cover,
              height: 90,
              width: 90,
            ),
          ),
        ),
      ),
    );

    // InkWell(
    //         onTap: () {
    //           setState(() {
    //             intImage = null;
    //           });
    //           modelSheet();
    //         },
    //         child: Center(
    //           child: ClipRRect(
    //             borderRadius: const BorderRadius.all(Radius.circular(80)),
    //             child: Image.network(
    //               fit: BoxFit.fill,
    //               height: 100,
    //               width: 100,
    //               state.networkImage ?? "",
    //               errorBuilder: (context, error, stackTrace) {
    //                 return const Stack(
    //                   alignment: Alignment.center,
    //                   children: [
    //                     Center(
    //                       child: CircleAvatar(
    //                         radius: 50,
    //                         backgroundColor: whiteF2F2F2Color,
    //                       ),
    //                     ),
    //                     Icon(
    //                         size: 70,
    //                         color: Colors.black38,
    //                         Icons.person_rounded),
    //                     // SvgPicture.asset(
    //                     //     '$svgAssetsBasePath/camera_icon.svg')
    //
    //                     Icon(
    //                         size: 70,
    //                         color: Colors.black38,
    //                         Icons.person_rounded)
    //                   ],
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       )

    // InkWell(
    //     onTap: () {
    //       setState(() {
    //         intImage = null;
    //       });
    //       modelSheet();
    //     },
    //     child: Center(
    //       child: CircleAvatar(
    //         radius: 50,
    //         backgroundColor: Colors.transparent,
    //         child: ClipRRect(
    //           clipBehavior: Clip.antiAlias,
    //           borderRadius: const BorderRadius.all(Radius.circular(60)),
    //           child:
    //           CachedNetworkImage(
    //             imageUrl: widgets.initialImagePath ?? "",
    //
    //             // imageBuilder: (context, imageProvider) => Container(
    //             //   decoration: BoxDecoration(
    //             //     image: DecorationImage(
    //             //       image: imageProvider,
    //             //       fit: BoxFit.fill,
    //             //
    //             //       // colorFilter:
    //             //       //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
    //             //     ),
    //             //   ),
    //             // ),
    //             placeholder: _loader,
    //             errorWidget: _error,
    //           ),
    //         ),
    //       ),
    //     ),
    //   )
    // : (imagePath?.isNotEmpty == true
    //     ? InkWell(
    //         onTap: () {
    //           modelSheet();
    //         },
    //         child: Stack(
    //           children: [
    //             Center(
    //               child: CircleAvatar(
    //                 radius: 50,
    //                 backgroundColor: Colors.transparent,
    //                 child: ClipRRect(
    //                   clipBehavior: Clip.antiAlias,
    //                   borderRadius:
    //                       const BorderRadius.all(Radius.circular(60)),
    //                   child: Image.file(
    //                     File(imagePath ?? ""),
    //                     fit: BoxFit.cover,
    //                     height: 90,
    //                     width: 90,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 setState(() {
    //                   imagePath = null;
    //                   //   intImage=widgets.initialImagePath;
    //                 });
    //                 intImage = widgets.initialImagePath;
    //               },
    //               child: const Positioned(
    //                 top: 64,
    //                 left: 30,
    //                 right: -52,
    //                 child: Icon(color: Colors.red, Icons.delete_forever)
    //                 // SvgPicture.asset(
    //                 //     '$svgAssetsBasePath/camera_icon.svg')
    //                 ,
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     : InkWell(
    //         onTap: () {
    //           modelSheet();
    //         },
    //         child: Stack(
    //           alignment: Alignment.center,
    //           children: [
    //             const Center(
    //               child: CircleAvatar(
    //                 radius: 50,
    //                 backgroundColor: whiteF2F2F2Color,
    //               ),
    //             ),
    //             const Icon(
    //                 size: 70, color: Colors.black38, Icons.person_rounded),
    //             Positioned(
    //               top: 64,
    //               left: 30,
    //               right: -52,
    //               child: SvgPicture.asset(
    //                   '$svgAssetsBasePath/camera_icon.svg'),
    //             )
    //           ],
    //         ),
    //       ));
  }

  modelSheet() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: purple4C4DDCColor,
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Select Image Source",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontWeight: medium,
                              fontSize: 16,
                              color: whiteFFFFFFColor),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AppRouter.navigatorKey.currentState?.pop();
                        },
                        child:
                        const Icon(Icons.close, color: whiteFFFFFFColor))
                  ],
                ),
              ),
              const Divider(
                height: 0.5,
                thickness: 0.5,
                color: whiteFFFFFFColor,
              ),
              ListTile(
                onTap: () {
                  context
                      .read<UploadImageCubit>()
                      .selectImage(ImageSource.camera);
                },
                leading:
                const Icon(Icons.camera_alt, color: whiteFFFFFFColor),
                title: Text(
                  "Camera",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: medium,
                        fontSize: 14,
                        color: whiteFFFFFFColor),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  context
                      .read<UploadImageCubit>()
                      .selectImage(ImageSource.gallery);
                },
                leading: const Icon(Icons.picture_in_picture,
                    color: whiteFFFFFFColor),
                title: Text(
                  "Gallery",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: medium,
                        fontSize: 14,
                        color: whiteFFFFFFColor),
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(child: Icon(Icons.error));
  }
}




