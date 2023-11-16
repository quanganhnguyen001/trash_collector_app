import 'package:flutter/material.dart';

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
