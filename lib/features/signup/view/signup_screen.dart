import 'package:flutter/material.dart';

import '../../../gen/assets/assets.gen.dart';
import '../../../gen/localization/l10n.dart';

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
                    // controller: context.read<LoginCubit>().emailController,
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
                    // controller: context.read<LoginCubit>().emailController,
                    validator: (value) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value ?? Str.of(context).valid_email)) {
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
                    // controller: context.read<LoginCubit>().passwordController,
                    validator: (value) {
                      if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                          .hasMatch(value ?? Str.of(context).valid_password)) {
                        return '';
                      }
                      return null;
                    },
                    // obscureText: state.isShowPassword,
                    height: 53,
                    padding: const EdgeInsets.only(left: 16),
                    hinText: Str.of(context).password,
                    hintStyle: AppTextStyle.paragraphMedium(
                        color: ColorPalettes.darkgrayColor),
                    // rightIcon: InkWell(
                    //   onTap: () {
                    //     // context.read<LoginCubit>().hideShowPassword();
                    //   },
                    //   child: state.isShowPassword
                    //       ? Assets.images.passwordHide.image()
                    //       : Assets.images.passwordShow.image(),
                    // ),
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
                        // if (formKey.currentState!.validate()) {
                        //   context.read<LoginCubit>().login(
                        //         ctx: context,
                        //       );
                        // }
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
                                    .pushNamed(SignupScreen.routeName);
                              },
                            style:
                                AppTextStyle.buttonSmall(color: Colors.green))
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonComponents extends StatelessWidget {
  const ButtonComponents(
      {super.key,
      this.width,
      this.height,
      this.radius,
      this.padding,
      this.backgroundColor,
      this.borderColor,
      this.onPressed,
      this.title,
      this.textStyle});
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? title;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: backgroundColor,
          backgroundColor: backgroundColor,
          minimumSize: Size(width ?? 275, height ?? 56),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? Colors.transparent),
              borderRadius: BorderRadius.circular(radius ?? 16)),
        ),
        child: Text(title ?? '', style: textStyle),
      ),
    );
  }
}

class SmallButtonsComponents extends StatelessWidget {
  const SmallButtonsComponents(
      {super.key, this.title, this.textStyle, this.onTap});
  final String? title;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title ?? '',
        style: textStyle,
      ),
    );
  }
}

class TextFieldComponents extends StatelessWidget {
  const TextFieldComponents(
      {super.key,
      this.width,
      this.height,
      this.radius,
      this.backgroundColor,
      this.borderColor,
      this.padding,
      this.hinText,
      this.hintStyle,
      this.suffixIcon,
      this.controller,
      this.onChanged,
      this.obscureText,
      this.keyboardType,
      this.rightIcon,
      this.validator,
      this.onSaved});
  final double? width;
  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final String? hinText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final TextInputType? keyboardType;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: onSaved,
      validator: validator,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: ColorPalettes.grayColor,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: ColorPalettes.grayColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: ColorPalettes.grayColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: ColorPalettes.grayColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: ColorPalettes.grayColor,
            )),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintText: hinText,
        hintStyle: hintStyle,
        suffixIcon: rightIcon,
      ),
    );
  }
}

class AppTextStyle {
  static TextStyle H1({
    Color color = const Color(0xFF3B3936),
  }) {
    return const TextStyle().copyWith(
      color: color,
      fontSize: 56,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700,
      height: 1.05,
      letterSpacing: -1,
    );
  }

  static TextStyle H2({
    Color color = const Color(0xFF3B3936),
  }) {
    return const TextStyle().copyWith(
      color: color,
      fontSize: 40,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -1,
    );
  }

  static TextStyle H3({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 32,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700,
      height: 1.31,
      letterSpacing: -1,
    );
  }

  static TextStyle H4({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 24,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      height: 1.33,
      letterSpacing: -0.50,
    );
  }

  static TextStyle H5({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 20,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      height: 1.30,
      letterSpacing: -0.50,
    );
  }

  static TextStyle paragraphLarge({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
      height: 1.62,
      letterSpacing: -0.50,
    );
  }

  static TextStyle paragraphMedium({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
      height: 1.62,
      letterSpacing: -0.50,
    );
  }

  static TextStyle paragraphSmall({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      height: 1.50,
    );
  }

  static TextStyle buttonLarge({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      height: 1.22,
      letterSpacing: -0.50,
    );
  }

  static TextStyle buttonMedium({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      height: 1.12,
    );
  }

  static TextStyle buttonSmall({
    Color color = const Color(0xFF3B3936),
  }) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      height: 1.14,
    );
  }
}

class ColorPalettes {
  static const Color secondaryColor = Color.fromRGBO(101, 170, 234, 1);
  static const Color darkgrayColor = Color.fromRGBO(120, 116, 109, 1);
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color darkColor = Color.fromRGBO(60, 58, 54, 1);
  static const Color lightGrayColor = Color.fromRGBO(248, 242, 238, 1);
  static const Color grayColor = Color.fromRGBO(190, 186, 179, 1);
  static const Color primaryColor = Color.fromRGBO(227, 86, 42, 1);
  static const Color chatGptBackgroundColor = Color(0xFF343541);
  static const Color cardColor = Color(0xFF444654);
}
