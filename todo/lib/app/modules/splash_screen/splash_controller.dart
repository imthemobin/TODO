import 'package:get/get.dart';
import 'package:todo/app/modules/home/view.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => Home());
  }
}
