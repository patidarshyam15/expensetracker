import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import '../../../routes/route_name.dart';
import '../../../storage/app_storage.dart';
import '../../service/reminder_service_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppStorage appStorage = AppStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStep();
  }

  initStep() async {
    // await Future.delayed(const Duration(seconds: 0));
    String? email = await appStorage.getUserEmail();
    String? firstScreen = await appStorage.getFirstIntro();
    if (firstScreen != null) {
      if (email != null) {
        bool isServiceRunning = await FlutterBackgroundService().isRunning();
       if(!isServiceRunning){
         await initializeService();
       }
        Get.offNamedUntil(RouteName.BOTTOM_NAV_BAR, (route) => false);
      } else {
        Get.offNamedUntil(RouteName.LOGIN_REGISTER, (route) => false);
      }
    } else {
      Get.offNamedUntil(RouteName.ONBOARDING_SCREEN, (route) => false);
    }
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
