import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../gen/localization/l10n.dart';

class AlertDialogComponent {
  static showCupertinoAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPressed,
  }) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text(Str.of(context).no),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              CupertinoDialogAction(
                  onPressed: onPressed,
                  child: Text(
                    Str.of(context).yes,
                    style: const TextStyle(color: Colors.blue),
                  ))
            ],
          );
        });
  }
}
