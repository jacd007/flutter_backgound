import 'package:get/get.dart';

import '../core/core_m.dart';
import '../features/features_m.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(ThemeController());
    Get.put(RouterController());
    Get.put(AuthController());
    Get.lazyPut(() => HomeController());
    // Puedes inyectar aquí las dependencias para el módulo Home
  }
}
