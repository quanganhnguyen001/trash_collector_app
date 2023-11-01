import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../login/view/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final controller = PageController();

  late List<OnboardModel> tabs = [
    OnboardModel(
        // title: Str.of(context).onboardTitle1,
        title: 'Phân loại rác để bảo vệ môi trường',
        imageAssets: 'assets/images/recycle_trash_img.png'),
    OnboardModel(
        title: 'Thuận tiện thu gom',
        // title: Str.of(context).onboardTitle2,

        imageAssets: 'assets/images/trash_collector_img.png'),
    OnboardModel(
        title: 'Vì môi trường xanh sạch đẹp',
        // title: Str.of(context).onboardTitle3,

        imageAssets: 'assets/images/green_natural_img.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routeName, (route) => false);
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('isFirst', 'No');
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      'skip',
                      // Str.of(context).skip,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                  )),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.asset(tabs[index].imageAssets),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            tabs[index].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            // Str.of(context).onboardLabel,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SizedBox(
                          height: 69,
                        ),
                      ],
                    ),
                  ),
                );
              },
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          height: 6,
                          width: currentIndex == index ? 16 : 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: currentIndex == index
                                  ? Colors.green
                                  : Colors.grey),
                        )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    if (currentIndex == tabs.length - 1) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName, (route) => false);
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('isFirst', 'No');
                    } else {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(311, 56),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    currentIndex == tabs.length - 1 ? 'start' : 'next',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    // ? Str.of(context).start
                    // : Str.of(context).next,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OnboardModel {
  final String title;

  final String imageAssets;
  OnboardModel({
    required this.title,
    required this.imageAssets,
  });
}
