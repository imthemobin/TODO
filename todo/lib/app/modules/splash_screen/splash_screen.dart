import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/modules/splash_screen/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  final splashController = Get.put(SplashController());

  SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash.gif',
            scale: 1.5,
          ),
          GradientText('Todo APP | برنامه انجام وظایف', colors: const[
            Color.fromARGB(255, 189, 195, 199),
            Color.fromARGB(255, 44, 62, 80)
          ],
          style: TextStyle(
            fontSize: 14.0.sp
          ),
          ),
          SizedBox(height: 2.0.wp,),
          Text('Developer: Mobin MasharMaleki',style: TextStyle(
            color: Colors.black,
            fontSize: 8.0.sp
          ),),
          SizedBox(height: 10.0.wp,),
          SpinKitFadingCube(
            color: purple.withOpacity(0.5),
            size: 40,
          )
        ],
      ),
    ));
  }
}
