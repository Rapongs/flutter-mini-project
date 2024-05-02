import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    navigateToLogin();
    super.onReady();
  }

  void navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}
