import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/features/auth/base_screen.dart';
import 'package:trash_collector_app/features/login/view/login_screen.dart';
import 'package:trash_collector_app/features/signup/cubit/signup_cubit.dart';

import '../../../common/widget/button_component.dart';
import '../../../common/widget/textfield_component.dart';
import '../../../gen/assets/assets.gen.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String routeName = '/SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: ColorPalettes.darkColor,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
                      Assets.images.bgSignup.image(height: 250),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Text(
                          Str.of(context).sign_up,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.H4(),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldComponents(
                          controller:
                              context.read<SignupCubit>().nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Str.of(context).valid_name;
                            }
                            return null;
                          },
                          height: 53,
                          padding: const EdgeInsets.only(left: 16),
                          hinText: Str.of(context).name,
                          hintStyle: AppTextStyle.paragraphMedium(
                              color: ColorPalettes.darkgrayColor),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldComponents(
                          controller:
                              context.read<SignupCubit>().emailController,
                          validator: (value) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(
                                    value ?? Str.of(context).valid_email)) {
                              return '';
                            }
                            return null;
                          },
                          height: 53,
                          padding: const EdgeInsets.only(left: 16),
                          hinText: 'Email',
                          hintStyle: AppTextStyle.paragraphMedium(
                              color: ColorPalettes.darkgrayColor),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldComponents(
                          controller:
                              context.read<SignupCubit>().passwordController,
                          validator: (value) {
                            if (!RegExp(
                                    r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                                .hasMatch(
                                    value ?? Str.of(context).valid_password)) {
                              return '';
                            }
                            return null;
                          },
                          obscureText: state.isShowPassword,
                          height: 53,
                          padding: const EdgeInsets.only(left: 16),
                          hinText: Str.of(context).password,
                          hintStyle: AppTextStyle.paragraphMedium(
                              color: ColorPalettes.darkgrayColor),
                          rightIcon: InkWell(
                            onTap: () {
                              context.read<SignupCubit>().hideShowPassword();
                            },
                            child: state.isShowPassword
                                ? Assets.images.passwordHide.image()
                                : Assets.images.passwordShow.image(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ButtonComponents(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<SignupCubit>().signUp(
                                      ctx: context,
                                    );
                              }
                            },
                            height: 56,
                            radius: 16,
                            title: Str.of(context).sign_up,
                            textStyle: AppTextStyle.buttonMedium(
                                color: ColorPalettes.whiteColor),
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                            text: Str.of(context).have_account,
                            style: AppTextStyle.buttonSmall(
                                color: ColorPalettes.darkgrayColor),
                            children: [
                              TextSpan(
                                  text: Str.of(context).login,
                                  recognizer: TapAndPanGestureRecognizer()
                                    ..onTapUp = (_) {
                                      Navigator.of(context)
                                          .pushNamed(LoginScreen.routeName);
                                    },
                                  style: AppTextStyle.buttonSmall(
                                      color: Colors.green))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
