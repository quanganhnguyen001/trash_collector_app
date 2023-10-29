import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
  }

  void check() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context)
        .pushNamedAndRemoveUntil(OnboardingScreen.routeName, (route) => false);
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
