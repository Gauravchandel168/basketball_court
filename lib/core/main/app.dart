import 'dart:async' as BlocOverrides;

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import '../../presentation/routers/app_routers.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';


import '../theme/light_theme.dart';



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widgets is the root of your application.
  @override

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return kReleaseMode ? _releaseWidget() : _debugWidget();
  }

  _releaseWidget() => MaterialApp(
    title: "basketball",
    theme: appLightTheme(context),
    themeMode: ThemeMode.light,
    debugShowCheckedModeBanner: false,
    navigatorKey: AppRouter.navigatorKey,
    initialRoute: AppRouter.dashBoardScreen,
    onGenerateRoute: AppRouter.onGenerateRoute,
    builder: (context, child) {
      return _responsiveWrapperWidget(child!);

      //EasyLoading.init()(context, child);
    },
  );


  _debugWidget() => BlocOverrides.runZoned(
          () => DevicePreview(
        enabled: false,
        builder: (context) => MaterialApp(
          title: "basketball",
          theme: appLightTheme(context),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          navigatorKey: AppRouter.navigatorKey,
          initialRoute: AppRouter.dashBoardScreen,
          onGenerateRoute: AppRouter.onGenerateRoute,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            child = _responsiveWrapperWidget(child!);
            return DevicePreview.appBuilder(context, child);

            //EasyLoading.init()(context, child);
          },
        ), // Wrap your app
      ),
    //  blocObserver: AppBlocObserver()
  );

  /// used to make responsive. set breakpoint here.
  _responsiveWrapperWidget(Widget child) => ResponsiveWrapper.builder(
    ClampingScrollWrapper.builder(context, child),
    breakpoints: const [
      ResponsiveBreakpoint.resize(320, name: MOBILE),
      ResponsiveBreakpoint.autoScale(450, name: TABLET),
    ],
  );

}
