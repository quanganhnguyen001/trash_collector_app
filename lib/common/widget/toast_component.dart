import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponent {
  static showToast({
    required Color color,
    required String msg,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: color,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
        fontSize: 18);
  }
}
