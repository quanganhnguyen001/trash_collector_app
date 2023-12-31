// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dont_have_account":
            MessageLookupByLibrary.simpleMessage("Chưa có tài khoản?"),
        "email_are_use":
            MessageLookupByLibrary.simpleMessage("Email đã được sử dụng"),
        "enter_email":
            MessageLookupByLibrary.simpleMessage("Vui lòng nhập email của bạn"),
        "forgot_pass": MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
        "forgot_pass_des": MessageLookupByLibrary.simpleMessage(
            "Nhập Email của bạn và chúng tôi sẽ gửi cho bạn link đặt lại mật khẩu"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
        "have_account":
            MessageLookupByLibrary.simpleMessage("Đã có tài khoản? "),
        "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "login_exception": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra lại email và mật khẩu"),
        "name": MessageLookupByLibrary.simpleMessage("Tên"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Đặt lại mật khẩu"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "valid_email": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập đúng định dạng email"),
        "valid_name": MessageLookupByLibrary.simpleMessage("Vui lòng nhập tên"),
        "valid_password": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập đúng định dạng mật khẩu")
      };
}
