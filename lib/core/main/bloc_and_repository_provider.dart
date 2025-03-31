
import 'package:basketball/logic/navigation/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// import '../../data/respositories/firebase_cloudStroage_repository.dart';

import 'app.dart';

class BlocAndRepositoryProvider extends StatelessWidget {
  const BlocAndRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       // BlocProvider<InternetCubit>(create: (context) => InternetCubit()),

        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),

      ],
      child: const MyApp(),
    );
  }
}