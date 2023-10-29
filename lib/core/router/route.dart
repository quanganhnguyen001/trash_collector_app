import 'package:flutter/material.dart';
import 'package:trash_collector_app/features/onboarding/view/onboarding_screen.dart';

import '../../features/splash/view/splash_screen.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    if (settings.name == SplashScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: SplashScreen.routeName),
        builder: (_) => const SplashScreen(),
      );
    }
    if (settings.name == OnboardingScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: OnboardingScreen.routeName),
        builder: (_) => const OnboardingScreen(),
      );
    }

    return null;
  }
}
