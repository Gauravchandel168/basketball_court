// import 'package:firebase_app_check/firebase_app_check.dart';




import 'package:flutter/material.dart';

import 'app.dart';
import 'bloc_and_repository_provider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: kIsWeb
  //       ? HydratedStorage.webStorageDirectory
  //       : await getApplicationDocumentsDirectory(),
  // );
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(BlocAndRepositoryProvider());
}
