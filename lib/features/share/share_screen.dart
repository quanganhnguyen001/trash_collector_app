import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trash_collector_app/features/auth/model/user_model.dart';
import 'package:trash_collector_app/theme/app_style.dart';

import '../../common/widget/button_component.dart';
import '../../gen/assets/assets.gen.dart';
import '../../theme/color_paletes.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Mời hàng xóm',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Assets.images.launcherIcon.image(height: 200),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'NHẬN NGAY 1000 điểm Khi mời hàng xóm đăng ký sử dụng thành công TrashMaster cả bạn và hàng xóm đều sẽ được 1000 điểm.',
              textAlign: TextAlign.center,
              style: AppTextStyle.H4(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ButtonComponents(
            onPressed: () {
              Share.share(
                  '${userModel.name} mời bạn tải App TrashMaster - Ứng dụng phân loại rác tại nguồn được tích điểm, đổi quà. Tải App ngay để nhận 1000 điểm thưởng từ TrashMaster nhé! ');
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update(UserModel(
                    point: userModel.point! + 1000,
                  ).toMap());
            },
            height: 56,
            radius: 16,
            title: 'Mời hàng xóm ngay',
            textStyle:
                AppTextStyle.buttonMedium(color: ColorPalettes.whiteColor),
            backgroundColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
