import 'package:flutter/material.dart';
import 'package:trash_collector_app/features/upload/view/upload_screen.dart';

import '../../../gen/assets/assets.gen.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../../auth/model/user_model.dart';

class RecycleScreen extends StatefulWidget {
  const RecycleScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<RecycleScreen> createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Str.of(context).hello,
                        style: AppTextStyle.paragraphLarge(
                            color: ColorPalettes.darkColor),
                      ),
                      Text(
                        widget.user.name ?? '',
                        style: AppTextStyle.H3(
                            color: const Color.fromRGBO(51, 51, 51, 1)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            // Navigator.of(context)
                            //     .pushNamed(ChatGptScreen.routeName);
                          },
                          child: Assets.images.chatLogo.image(height: 40)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(UploadScreen.routeName);
        },
      ),
    );
  }
}
