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

  /// `Cá nhân`
  String get profile {
    return Intl.message(
      'Cá nhân',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt`
  String get settings {
    return Intl.message(
      'Cài đặt',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào,`
  String get hello {
    return Intl.message(
      'Xin chào,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất`
  String get log_out {
    return Intl.message(
      'Đăng xuất',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin tài khoản`
  String get info_account {
    return Intl.message(
      'Thông tin tài khoản',
      name: 'info_account',
      desc: '',
      args: [],
    );
  }

  /// `Tên tài khoản`
  String get username {
    return Intl.message(
      'Tên tài khoản',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ`
  String get location {
    return Intl.message(
      'Địa chỉ',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật số điện thoại`
  String get update_phone {
    return Intl.message(
      'Cập nhật số điện thoại',
      name: 'update_phone',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn Đăng xuất ?`
  String get alert_logout {
    return Intl.message(
      'Bạn có chắc muốn Đăng xuất ?',
      name: 'alert_logout',
      desc: '',
      args: [],
    );
  }

  /// `Có`
  String get yes {
    return Intl.message(
      'Có',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Không`
  String get no {
    return Intl.message(
      'Không',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật tài khoản`
  String get update_info {
    return Intl.message(
      'Cập nhật tài khoản',
      name: 'update_info',
      desc: '',
      args: [],
    );
  }

  /// `Chuyển đổi ngôn ngữ`
  String get change_language {
    return Intl.message(
      'Chuyển đổi ngôn ngữ',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Lưu`
  String get save {
    return Intl.message(
      'Lưu',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Chụp ảnh`
  String get from_camera {
    return Intl.message(
      'Chụp ảnh',
      name: 'from_camera',
      desc: '',
      args: [],
    );
  }

  /// `Thư viện ảnh`
  String get from_gallery {
    return Intl.message(
      'Thư viện ảnh',
      name: 'from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại`
  String get valid_phone {
    return Intl.message(
      'Vui lòng nhập số điện thoại',
      name: 'valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại`
  String get phone {
    return Intl.message(
      'Số điện thoại',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm`
  String get search {
    return Intl.message(
      'Tìm kiếm',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Đổi rác lấy \nquà`
  String get trade_gift {
    return Intl.message(
      'Đổi rác lấy \nquà',
      name: 'trade_gift',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lịch thu gom tại nhà`
  String get schedule_home_collection {
    return Intl.message(
      'Đặt lịch thu gom tại nhà',
      name: 'schedule_home_collection',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử thu \ngom`
  String get history_collecion {
    return Intl.message(
      'Lịch sử thu \ngom',
      name: 'history_collecion',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get home {
    return Intl.message(
      'Trang chủ',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Tên rác`
  String get trash_name {
    return Intl.message(
      'Tên rác',
      name: 'trash_name',
      desc: '',
      args: [],
    );
  }

  /// `Nhập tên rác`
  String get enter_trash_name {
    return Intl.message(
      'Nhập tên rác',
      name: 'enter_trash_name',
      desc: '',
      args: [],
    );
  }

  /// `Mô tả`
  String get description {
    return Intl.message(
      'Mô tả',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Hình ảnh rác`
  String get trash_image {
    return Intl.message(
      'Hình ảnh rác',
      name: 'trash_image',
      desc: '',
      args: [],
    );
  }

  /// `Nhập mô tả`
  String get enter_description {
    return Intl.message(
      'Nhập mô tả',
      name: 'enter_description',
      desc: '',
      args: [],
    );
  }

  /// `Nhấn để chọn ảnh`
  String get select_image {
    return Intl.message(
      'Nhấn để chọn ảnh',
      name: 'select_image',
      desc: '',
      args: [],
    );
  }

  /// `Loại rác: `
  String get trash_type {
    return Intl.message(
      'Loại rác: ',
      name: 'trash_type',
      desc: '',
      args: [],
    );
  }

  /// `Nhập địa chỉ`
  String get enter_location {
    return Intl.message(
      'Nhập địa chỉ',
      name: 'enter_location',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ngày thu gom`
  String get select_date {
    return Intl.message(
      'Chọn ngày thu gom',
      name: 'select_date',
      desc: '',
      args: [],
    );
  }

  /// `Chọn thời gian thu gom`
  String get select_time {
    return Intl.message(
      'Chọn thời gian thu gom',
      name: 'select_time',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirm {
    return Intl.message(
      'Xác nhận',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Độ chính xác`
  String get accuracy {
    return Intl.message(
      'Độ chính xác',
      name: 'accuracy',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên rác`
  String get valid_trash_name {
    return Intl.message(
      'Vui lòng nhập tên rác',
      name: 'valid_trash_name',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mô tả`
  String get valid_trash_description {
    return Intl.message(
      'Vui lòng nhập mô tả',
      name: 'valid_trash_description',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập địa chỉ`
  String get valid_location {
    return Intl.message(
      'Vui lòng nhập địa chỉ',
      name: 'valid_location',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn ảnh`
  String get valid_image {
    return Intl.message(
      'Vui lòng chọn ảnh',
      name: 'valid_image',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử thu gom`
  String get history_collect {
    return Intl.message(
      'Lịch sử thu gom',
      name: 'history_collect',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách chờ`
  String get trash_wait {
    return Intl.message(
      'Danh sách chờ',
      name: 'trash_wait',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách đã thu gom`
  String get success_collect {
    return Intl.message(
      'Danh sách đã thu gom',
      name: 'success_collect',
      desc: '',
      args: [],
    );
  }

  /// `Voucher đã đổi`
  String get voucher_list {
    return Intl.message(
      'Voucher đã đổi',
      name: 'voucher_list',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật địa chỉ`
  String get update_location {
    return Intl.message(
      'Cập nhật địa chỉ',
      name: 'update_location',
      desc: '',
      args: [],
    );
  }

  /// `Xóa rác`
  String get delete_trash_user {
    return Intl.message(
      'Xóa rác',
      name: 'delete_trash_user',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn xóa ?`
  String get delete_trash_content {
    return Intl.message(
      'Bạn có chắc muốn xóa ?',
      name: 'delete_trash_content',
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
