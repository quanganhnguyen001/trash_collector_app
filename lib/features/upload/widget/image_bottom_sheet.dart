import 'package:flutter/material.dart';

import '../../../gen/localization/l10n.dart';

class ImageBottomSheet {
  static showImageBottomSheet({
    required BuildContext context,
    required void Function() ontap1,
    required void Function() ontap2,
  }) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SizedBox(
              height: 150,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(children: [
                  InkWell(
                    onTap: ontap1,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.camera,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          Str.of(context).from_camera,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: ontap2,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.image,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          Str.of(context).from_gallery,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ));
        });
  }
}
