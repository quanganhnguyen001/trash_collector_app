import 'package:flutter/material.dart';

import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.title,
  });
  final String label;
  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      title,
                      style: AppTextStyle.H5(color: ColorPalettes.darkColor),
                    ),
                    Text(
                      label,
                      style: AppTextStyle.paragraphMedium(
                          color: ColorPalettes.darkgrayColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
