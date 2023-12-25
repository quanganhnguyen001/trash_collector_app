import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/features/history/view/history_screen.dart';
import 'package:trash_collector_app/features/recycle/widget/video_widget.dart';
import 'package:trash_collector_app/features/upload/view/upload_screen.dart';
import 'package:trash_collector_app/features/voucher/view/voucher_screen.dart';

import '../../../common/cubit/user/user_cubit.dart';
import '../../../common/widget/textfield_component.dart';
import '../../../gen/assets/assets.gen.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../../auth/model/user_model.dart';
import '../../location/view/trash_location.dart';
import '../model/video.dart';

class RecycleScreen extends StatefulWidget {
  const RecycleScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<RecycleScreen> createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  @override
  void initState() {
    context.read<UserCubit>().loadUserData();

    super.initState();
  }

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
                            Navigator.of(context)
                                .pushNamed(TrashLocationScreen.routeName);
                          },
                          child:
                              Assets.images.locationTrashIc.image(height: 40)),
                      const SizedBox(
                        width: 10,
                      ),
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
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFieldComponents(
                radius: 12,
                hinText: Str.of(context).search,
                hintStyle: AppTextStyle.paragraphMedium(
                    color: ColorPalettes.darkgrayColor),
                rightIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(VoucherScreen.routeName,
                          arguments: widget.user);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Assets.images.giftBoxIc
                              .image(height: 40, color: Colors.white),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              Str.of(context).trade_gift,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(UploadScreen.routeName,
                          arguments: widget.user);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.lightBlueAccent,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Assets.images.scheduleIc
                              .image(height: 40, color: Colors.white),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              Str.of(context).schedule_home_collection,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(HistoryScreen.routeName,
                          arguments: widget.user);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.green,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Assets.images.historyIc
                              .image(height: 40, color: Colors.white),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              Str.of(context).history_collecion,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listVideo.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      children: [
                        Text(
                          listVideo[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                                height: 300,
                                child: VideoWidget(
                                  videoId: listVideo[index].videoId,
                                ))),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
