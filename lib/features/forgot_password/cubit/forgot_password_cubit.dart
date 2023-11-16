// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../gen/assets/assets.gen.dart';
import '../../../theme/app_style.dart';
import '../../login/view/login_screen.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final emailController = TextEditingController();
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  Future resetPassword({required BuildContext ctx}) async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((value) {
        showDialog(
            context: ctx,
            builder: (context) {
              return AlertDialog(
                actions: [
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              LoginScreen.routeName, (route) => false);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Assets.images.check.image(height: 56),
                content: Text(
                  'Go check your email and Login again',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.H4(color: Colors.red),
                ),
              );
            });
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: ctx,
          builder: (context) {
            Future.delayed((const Duration(seconds: 2)), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Assets.images.alertPassword.image(height: 56),
              content: Text(
                e.message.toString(),
                textAlign: TextAlign.center,
                style: AppTextStyle.H4(color: Colors.red),
              ),
            );
          });
      emailController.clear();
    }
    EasyLoading.dismiss();
  }
}
