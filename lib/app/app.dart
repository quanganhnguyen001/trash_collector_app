import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trash_collector_app/app/app_language/app_language_cubit.dart';

import 'package:trash_collector_app/features/auth/cubit/auth_cubit.dart';

import '../common/cubit/user/user_cubit.dart';
import '../core/router/route.dart';
import '../gen/localization/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<AppLanguageCubit>(
            create: (context) => AppLanguageCubit(),
          ),
          BlocProvider<UserCubit>(
            create: (context) => UserCubit()..loadUserData(),
          ),
        ],
        child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
              ),
              localizationsDelegates: const [
                Str.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: Str.delegate.supportedLocales,
              locale: context.read<AppLanguageCubit>().state.locale,
              onGenerateRoute: OnGenerateRoute.route,
              initialRoute: '/SplashScreen',
              builder: EasyLoading.init(),
            );
          },
        ),
      );
    });
  }
}
