import 'package:get/get.dart';

import '../../../config/config_m.dart';

class AuthController extends GetxController {
  final _isAuth = false.obs;
  get isAuth => _isAuth.value;

  @override
  onInit() {
    isAuthenticated();
    super.onInit();
  }

  Future<void> isAuthenticated() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAndToNamed(AppRoutes.home);
  }
}
