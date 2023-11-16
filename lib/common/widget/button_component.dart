import 'package:flutter/material.dart';

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
