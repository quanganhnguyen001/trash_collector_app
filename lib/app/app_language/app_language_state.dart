part of 'app_language_cubit.dart';

class AppLanguageState extends Equatable {
  final Locale locale;

  const AppLanguageState({
    required this.locale,
  });

  @override
  List<Object> get props => [
        locale.languageCode,
      ];

  AppLanguageState copyWith({
    Locale? locale,
  }) {
    return AppLanguageState(
      locale: locale ?? this.locale,
    );
  }
}
