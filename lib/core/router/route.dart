import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/common/cubit/user/user_cubit.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/cubit/home_admin_cubit.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/view/admin_screen.dart';
import 'package:trash_collector_app/features/auth/model/user_model.dart';
import 'package:trash_collector_app/features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:trash_collector_app/features/forgot_password/view/forgot_password_screen.dart';
import 'package:trash_collector_app/features/history/cubit/history_cubit.dart';
import 'package:trash_collector_app/features/history/view/history_screen.dart';
import 'package:trash_collector_app/features/history/widget/detail_trash_pending.dart';
import 'package:trash_collector_app/features/history/widget/edit_trash.dart';
import 'package:trash_collector_app/features/home/cubit/home_cubit.dart';
import 'package:trash_collector_app/features/location/cubit/trash_location_cubit.dart';
import 'package:trash_collector_app/features/location/view/trash_location.dart';
import 'package:trash_collector_app/features/login/cubit/login_cubit.dart';
import 'package:trash_collector_app/features/login/view/login_screen.dart';
import 'package:trash_collector_app/features/onboarding/view/onboarding_screen.dart';
import 'package:trash_collector_app/features/signup/cubit/signup_cubit.dart';
import 'package:trash_collector_app/features/signup/view/signup_screen.dart';
import 'package:trash_collector_app/features/home/view/home_screen.dart';
import 'package:trash_collector_app/features/update_profile/cubit/update_profile_cubit.dart';
import 'package:trash_collector_app/features/update_profile/view/update_profile_screen.dart';
import 'package:trash_collector_app/features/upload/cubit/upload_cubit.dart';
import 'package:trash_collector_app/features/upload/model/trash_model.dart';
import 'package:trash_collector_app/features/upload/view/upload_screen.dart';
import 'package:trash_collector_app/features/voucher/cubit/voucher_cubit.dart';

import '../../features/splash/view/splash_screen.dart';
import '../../features/update_profile/model/update_profile_arg.dart';
import '../../features/voucher/view/voucher_screen.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    if (settings.name == SplashScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: SplashScreen.routeName),
        builder: (_) => const SplashScreen(),
      );
    }
    if (settings.name == VoucherScreen.routeName) {
      final args = settings.arguments as UserModel;
      return MaterialPageRoute(
        settings: const RouteSettings(name: VoucherScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => VoucherCubit()..fetchVoucher(),
          child: VoucherScreen(
            userModel: args,
          ),
        ),
      );
    }
    if (settings.name == TrashLocationScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: TrashLocationScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => TrashLocationCubit(),
          child: TrashLocationScreen(),
        ),
      );
    }
    if (settings.name == AdminScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: AdminScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => HomeAdminCubit()..fetchDataAdmin(),
          child: AdminScreen(),
        ),
      );
    }

    if (settings.name == HistoryScreen.routeName) {
      final args = settings.arguments as UserModel;
      return MaterialPageRoute(
        settings: const RouteSettings(name: HistoryScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => HistoryCubit()..fetchData(),
          child: HistoryScreen(
            userModel: args,
          ),
        ),
      );
    }
    if (settings.name == UploadScreen.routeName) {
      final args = settings.arguments as UserModel;
      return MaterialPageRoute(
        settings: const RouteSettings(name: UploadScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => UploadCubit(),
          child: UploadScreen(
            userModel: args,
          ),
        ),
      );
    }

    if (settings.name == UpdateProfileScreen.routeName) {
      final args = settings.arguments as UpdateProfileArg;
      return MaterialPageRoute(
        settings: const RouteSettings(name: UpdateProfileScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => UpdateProfileCubit(),
          child: UpdateProfileScreen(
            arg: args,
          ),
        ),
      );
    }
    if (settings.name == OnboardingScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: OnboardingScreen.routeName),
        builder: (_) => const OnboardingScreen(),
      );
    }
    if (settings.name == LoginScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: LoginScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        ),
      );
    }
    if (settings.name == ForgotPasswordScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: ForgotPasswordScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => ForgotPasswordCubit(),
          child: const ForgotPasswordScreen(),
        ),
      );
    }
    if (settings.name == HomeScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: HomeScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomeScreen(),
        ),
      );
    }
    if (settings.name == SignupScreen.routeName) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: SignupScreen.routeName),
        builder: (_) => BlocProvider(
          create: (context) => SignupCubit(),
          child: const SignupScreen(),
        ),
      );
    }

    return null;
  }
}
