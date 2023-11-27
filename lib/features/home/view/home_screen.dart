import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/features/auth/base_screen.dart';
import 'package:trash_collector_app/features/profile/view/profile_screen.dart';
import 'package:trash_collector_app/features/recycle/view/recycle_screen.dart';
import 'package:trash_collector_app/features/setting/view/setting_screen.dart';

import '../../../common/cubit/user/user_cubit.dart';
import '../../../gen/assets/assets.gen.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';

import '../../auth/model/user_model.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
            List<Widget> page = [
              RecycleScreen(
                user: userState.user ?? const UserModel(),
              ),
              const ProfileScreen(),
              SettingScreen(user: userState.user ?? const UserModel()),
            ];
            return Scaffold(
              body: page[homeState.currentIndex],
              bottomNavigationBar: Container(
                height: 98,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: ColorPalettes.grayColor),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: BottomNavigationBar(
                    onTap: (value) {
                      context.read<HomeCubit>().changeBottomNavBar(value);
                    },
                    unselectedItemColor: ColorPalettes.grayColor,
                    selectedItemColor: Colors.green,
                    unselectedLabelStyle: AppTextStyle.paragraphMedium(),
                    selectedLabelStyle: AppTextStyle.paragraphMedium(),
                    currentIndex: homeState.currentIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Icon(Icons.recycling,
                              color: homeState.currentIndex == 0
                                  ? Colors.green
                                  : ColorPalettes.grayColor),
                        ),
                        label: Str.of(context).home,
                      ),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Assets.images.profile.image(
                                color: homeState.currentIndex == 1
                                    ? Colors.green
                                    : ColorPalettes.grayColor),
                          ),
                          label: Str.of(context).profile),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Assets.images.wheel1.image(
                                color: homeState.currentIndex == 2
                                    ? Colors.green
                                    : ColorPalettes.grayColor),
                          ),
                          label: Str.of(context).settings),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      );
    });
  }
}
