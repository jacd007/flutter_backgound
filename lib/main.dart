import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/config_m.dart';
import 'core/core_m.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await DefaultFirebaseOptions.initialized();
  await AppBinding().dependencies();

  await BackgroundServiceManager.initialize();

  // Archivo main.dart o en tu AppWidget
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // if (!CheckPlatform.isModeWeb) await FCMServices.initializeApp();
  // if (!CheckPlatform.isModeMobile) {
  //   await notificationInitialize(navigatorKey: navigatorKey);
  // }

  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  const MyApp({this.navigatorKey, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final textTheme = AppColors.createTextTheme(context, "Poppins", "Poppins");
    final theme = MaterialTheme(textTheme);

    return GetMaterialApp(
      title: Tk.titleApp.tr,
      debugShowCheckedModeBanner: false,
      navigatorKey: widget.navigatorKey, // Asigna la GlobalKey aquí
      initialRoute: AppRoutes.main,
      getPages: AppRoutes.pages,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: themeController.themeStateSettings,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
    );
  }
}
