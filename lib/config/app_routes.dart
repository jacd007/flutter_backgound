import 'package:get/get.dart';

import '../core/core_m.dart';
import '../features/features_m.dart';

class AppRoutes {
  AppRoutes._();

  static const _transition = Transition.rightToLeft;
  static const _transitionDuration = Duration(milliseconds: 400);

  static const String main = '/';
  static const String error = '/error';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static final pages = [
    GetPage(
      name: main,
      page: () => SplashPage(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      // binding: AuthBinding(),
    ),
    GetPage(
      name: error,
      page: () => ErrorPage(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      // binding: AuthBinding(),
    ),
    // **************************************************************
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: _transition,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      // binding: AuthBinding(),
    ),
    GetPage(
      name: home,
      page: () => HomeMainPage(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      // binding: HomeBinding(),
    ),
    // ...
  ];
}

// Puedes crear bindings específicos para cada módulo si lo necesitas
// class AuthBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => AuthController());
//     // Puedes inyectar aquí tus repositorios y data sources para el módulo de autenticación
//   }
// }

// class HomeBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => HomeController());
//     // Puedes inyectar aquí las dependencias para el módulo Home
//   }
// }
