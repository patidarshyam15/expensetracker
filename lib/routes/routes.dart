
import 'package:expensetracker/routes/route_name.dart';
import 'package:expensetracker/screens/login_registraion/login_register_screen.dart';
import 'package:get/get.dart';

import '../screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/splash_screen/splash_screen.dart';

/// Routes

final routes = [
  GetPage(name: RouteName.LOGIN_REGISTER, page: () => const LoginRegistrationScreen()),
  GetPage(name: RouteName.BOTTOM_NAV_BAR, page: () => BottomNavBarScreen()),
  GetPage(name: RouteName.ONBOARDING_SCREEN, page: () => OnboardingScreen()),
];
