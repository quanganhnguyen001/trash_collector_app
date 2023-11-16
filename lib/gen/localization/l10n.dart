// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Str {
  Str();

  static Str? _current;

  static Str get current {
    assert(_current != null,
        'No instance of Str was loaded. Try to initialize the Str delegate before accessing Str.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Str> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Str();
      Str._current = instance;

      return instance;
    });
  }

  static Str of(BuildContext context) {
    final instance = Str.maybeOf(context);
    assert(instance != null,
        'No instance of Str present in the widget tree. Did you add Str.delegate in localizationsDelegates?');
    return instance!;
  }

  static Str? maybeOf(BuildContext context) {
    return Localizations.of<Str>(context, Str);
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message(
      'Đăng nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get password {
    return Intl.message(
      'Mật khẩu',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu?`
  String get forgot_password {
    return Intl.message(
      'Quên mật khẩu?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có tài khoản?`
  String get dont_have_account {
    return Intl.message(
      'Chưa có tài khoản?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get sign_up {
    return Intl.message(
      'Đăng ký',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Tên`
  String get name {
    return Intl.message(
      'Tên',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Đã có tài khoản? `
  String get have_account {
    return Intl.message(
      'Đã có tài khoản? ',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập đúng định dạng email`
  String get valid_email {
    return Intl.message(
      'Vui lòng nhập đúng định dạng email',
      name: 'valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập đúng định dạng mật khẩu`
  String get valid_password {
    return Intl.message(
      'Vui lòng nhập đúng định dạng mật khẩu',
      name: 'valid_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên`
  String get valid_name {
    return Intl.message(
      'Vui lòng nhập tên',
      name: 'valid_name',
      desc: '',
      args: [],
    );
  }

  /// `Nhập Email của bạn và chúng tôi sẽ gửi cho bạn link đặt lại mật khẩu`
  String get forgot_pass_des {
    return Intl.message(
      'Nhập Email của bạn và chúng tôi sẽ gửi cho bạn link đặt lại mật khẩu',
      name: 'forgot_pass_des',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lại mật khẩu`
  String get reset_password {
    return Intl.message(
      'Đặt lại mật khẩu',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email của bạn`
  String get enter_email {
    return Intl.message(
      'Vui lòng nhập email của bạn',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu?`
  String get forgot_pass {
    return Intl.message(
      'Quên mật khẩu?',
      name: 'forgot_pass',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng kiểm tra lại email và mật khẩu`
  String get login_exception {
    return Intl.message(
      'Vui lòng kiểm tra lại email và mật khẩu',
      name: 'login_exception',
      desc: '',
      args: [],
    );
  }

  /// `Email đã được sử dụng`
  String get email_are_use {
    return Intl.message(
      'Email đã được sử dụng',
      name: 'email_are_use',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Str> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Str> load(Locale locale) => Str.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
