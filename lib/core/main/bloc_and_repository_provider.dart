import 'package:basketball/logic/navigation/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// import '../../data/respositories/firebase_cloudStroage_repository.dart';

import '../../data/respositories/http_repository/auth_repository.dart';
import '../../logic/auth_cubit/auth_token_store_cubit.dart';
import '../../logic/internet/internet_cubit.dart';
import '../../logic/upload_image_cubit/upload_image_cubit.dart';
import 'app.dart';

class BlocAndRepositoryProvider extends StatelessWidget {
  const BlocAndRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [

          BlocProvider<InternetCubit>(create: (context) => InternetCubit()),

          BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),

          BlocProvider(create: (context) => AuthTokenStoreCubit()),
          BlocProvider(
            create: (context) => UploadImageCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}