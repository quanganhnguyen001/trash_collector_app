import 'package:flutter/material.dart';

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
      this.onSaved,
      this.maxlines});
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
  final int? maxlines;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
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
              color: Color.fromRGBO(190, 186, 179, 1),
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromRGBO(190, 186, 179, 1),
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromRGBO(190, 186, 179, 1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromRGBO(190, 186, 179, 1),
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromRGBO(190, 186, 179, 1),
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
