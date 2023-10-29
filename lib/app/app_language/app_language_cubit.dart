import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends HydratedCubit<AppLanguageState> {
  AppLanguageCubit()
      : super(
          const AppLanguageState(
            locale: Locale("vi"),
          ),
        );

  @override
  AppLanguageState? fromJson(Map<String, dynamic> json) {
    final String? languageName = json['language'];
    Locale locale = Locale(languageName ?? "vi");

    return AppLanguageState(
      locale: locale,
    );
  }

  @override
  Map<String, dynamic>? toJson(AppLanguageState state) {
    final Map<String, dynamic> stateJson = {
      'language': state.locale.languageCode.toString(),
    };
    return stateJson;
  }

  void changeLanguage(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
