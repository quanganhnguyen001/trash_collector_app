// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dont_have_account":
            MessageLookupByLibrary.simpleMessage("Don\'t have account? "),
        "email_are_use":
            MessageLookupByLibrary.simpleMessage("Email already in use"),
        "enter_email": MessageLookupByLibrary.simpleMessage("Enter your email"),
        "forgot_pass": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "forgot_pass_des": MessageLookupByLibrary.simpleMessage(
            "Enter your Email and we will send you a password reset link"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "have_account":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "login_exception": MessageLookupByLibrary.simpleMessage(
            "Please check your email and password again"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Reset password"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
        "valid_email":
            MessageLookupByLibrary.simpleMessage("Please enter valid email"),
        "valid_name": MessageLookupByLibrary.simpleMessage("Please enter name"),
        "valid_password":
            MessageLookupByLibrary.simpleMessage("Please enter valid password")
      };
}
