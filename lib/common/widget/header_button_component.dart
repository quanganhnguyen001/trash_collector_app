import 'package:flutter/material.dart';

class HeaderButtonComponents extends StatelessWidget {
  const HeaderButtonComponents(
      {super.key,
      this.width,
      this.height,
      this.icon,
      this.backgroundColor,
      this.widthBorder,
      this.borderColor,
      this.padding});
  final double? width;
  final double? height;
  final Widget? icon;
  final Color? backgroundColor;
  final double? widthBorder;
  final Color? borderColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width ?? 48,
      height: height ?? 48,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(
              width: widthBorder ?? 1,
              color: borderColor ?? const Color.fromRGBO(190, 186, 179, 1))),
      child: icon,
    );
  }
}
