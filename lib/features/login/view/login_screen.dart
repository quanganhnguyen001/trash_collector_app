import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/features/auth/base_screen.dart';
import 'package:trash_collector_app/features/signup/view/signup_screen.dart';

import '../../../common/widget/button_component.dart';
import '../../../common/widget/text_button_component.dart';
import '../../../common/widget/textfield_component.dart';
import '../../../gen/assets/assets.gen.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../../forgot_password/view/forgot_password_screen.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 52,
                      ),
                      Assets.images.bgLogin.image(height: 250),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Text(
                          Str.of(context).login,
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
                              context.read<LoginCubit>().emailController,
                          validator: (value) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(value ?? "")) {
                              return Str.of(context).valid_email;
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
                              context.read<LoginCubit>().passwordController,
                          validator: (value) {
                            if (!RegExp(
                                    r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                                .hasMatch(value ?? '')) {
                              return Str.of(context).valid_password;
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
                              context.read<LoginCubit>().hideShowPassword();
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
                      SmallButtonsComponents(
                        title: Str.of(context).forgot_password,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPasswordScreen.routeName);
                        },
                        textStyle:
                            AppTextStyle.buttonSmall(color: Colors.green),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ButtonComponents(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                      ctx: context,
                                    );
                              }
                            },
                            height: 56,
                            radius: 16,
                            title: Str.of(context).login,
                            textStyle: AppTextStyle.buttonMedium(
                                color: ColorPalettes.whiteColor),
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                            text: Str.of(context).dont_have_account,
                            style: AppTextStyle.buttonSmall(
                                color: ColorPalettes.darkgrayColor),
                            children: [
                              TextSpan(
                                  text: Str.of(context).sign_up,
                                  recognizer: TapAndPanGestureRecognizer()
                                    ..onTapUp = (_) {
                                      Navigator.of(context)
                                          .pushNamed(SignupScreen.routeName);
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
