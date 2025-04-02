// import 'package:firebase_app_check/firebase_app_check.dart';




import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data/model/user_model.dart';
import 'app.dart';
import 'bloc_and_repository_provider.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import this for Hive.initFlutter()
void main() async{
  //WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: kIsWeb
  //       ? HydratedStorage.webStorageDirectory
  //       : await getApplicationDocumentsDirectory(),
  // );
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter(); // Initialize Hive

  Hive.registerAdapter(UserModelAdapter()); // Register your model

  await Hive.openBox<UserModel>('userBox'); // Open Hive box

  runApp(BlocAndRepositoryProvider());
}
