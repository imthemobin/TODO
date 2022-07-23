import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/app/data/services/storage/services.dart';
import 'package:todo/app/modules/home/binding.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo/app/translations/localization_service.dart';
import 'app/modules/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalizationService(),
      locale: const Locale('en', 'Us'),
      fallbackLocale: const Locale('en', 'Us'),
      debugShowCheckedModeBanner: false,
      title: 'TODO app',
      home: SplashScreen(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
