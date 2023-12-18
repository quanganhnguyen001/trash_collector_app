import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:trash_collector_app/features/update_profile/model/update_profile_arg.dart';
import 'package:trash_collector_app/features/update_profile/view/update_profile_screen.dart';
import '../../../app/app_language/app_language_cubit.dart';
import '../../../gen/assets/assets.gen.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../../auth/model/user_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key, required this.user});
  static const String routeName = '/SettingsScreen';
  final UserModel user;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            Str.of(context).settings,
            style: AppTextStyle.H4(),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(child: Assets.images.bgSetting.image()),
            const SizedBox(
              height: 10,
            ),
            MenuItem(
              title: Str.of(context).change_language,
              icon: const Icon(Icons.language),
              change: BlocBuilder<AppLanguageCubit, AppLanguageState>(
                builder: (context, state) {
                  return AnimatedToggleSwitch<Locale>.rolling(
                    borderColor: Colors.grey,
                    indicatorColor: Colors.green,
                    indicatorSize: const Size(48, 100),
                    height: 36,
                    current: Localizations.localeOf(context),
                    values: Str.delegate.supportedLocales,
                    onChanged: context.read<AppLanguageCubit>().changeLanguage,
                    iconBuilder: (locale, size, value) {
                      var data = Center(
                          child: Text(
                        locale.languageCode.toUpperCase(),
                        style: const TextStyle(color: Colors.grey),
                      ));
                      if (value) {
                        data = Center(
                            child: Text(locale.languageCode.toUpperCase(),
                                style: const TextStyle(color: Colors.white)));
                      }
                      return data;
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // MenuItem(
            //   title: Str.of(context).change_theme,
            //   icon: const Icon(Icons.dark_mode),
            //   change: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 16),
            //     child: BlocBuilder<AppThemeCubit, AppThemeState>(
            //       builder: (context, state) {
            //         return AnimatedToggleSwitch<AppTheme>.rolling(
            //           indicatorSize: const Size(48, 100),
            //           borderColor: Colors.grey,
            //           indicatorColor: Colors.green,
            //           height: 36,
            //           current: context.read<AppThemeCubit>().state.appTheme,
            //           values: const [AppTheme.dark, AppTheme.light],
            //           onChanged: context.read<AppThemeCubit>().changeTheme,
            //           iconBuilder: (theme, size, value) {
            //             var data = Center(child: Text(theme.name.toString()));
            //             if (value) {
            //               data = Center(child: Text(theme.name.toString()));
            //             }
            //             return data;
            //           },
            //         );
            //       },
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(UpdateProfileScreen.routeName,
                    arguments: UpdateProfileArg(
                        name: widget.user.name ?? '',
                        phone: widget.user.phone ?? '',
                        imageUrl: widget.user.imageUrl ?? '',
                        location: widget.user.location ?? ''));
              },
              child: MenuItem(
                title: Str.of(context).update_info,
                icon: const Icon(Icons.person),
                change: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.change,
  });
  final String title;
  final Widget icon;
  final Widget change;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorPalettes.grayColor),
              borderRadius: BorderRadius.circular(16),
              color: ColorPalettes.whiteColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      icon,
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: AppTextStyle.H5(color: ColorPalettes.darkColor),
                      ),
                    ],
                  ),
                ),
                change
              ],
            ),
          )),
    );
  }
}
