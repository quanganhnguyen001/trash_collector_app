// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_collector_app/features/login/view/login_screen.dart';
import 'package:trash_collector_app/features/onboarding/view/onboarding_screen.dart';
import 'package:trash_collector_app/gen/assets/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    check();
    super.initState();
  }

  void check() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? check = prefs.getString('isFirst');
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    if (check == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          OnboardingScreen.routeName, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Assets.images.launcherIcon.image(height: 300),
          ),
        ],
      ),
    );
  }
}
