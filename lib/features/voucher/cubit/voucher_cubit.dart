import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trash_collector_app/features/auth/model/user_model.dart';
import 'package:trash_collector_app/features/voucher/model/voucher_model.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(const VoucherState([], 0));

  addVoucher(
      {required String? nameVoucher,
      required String? voucherDescription,
      required String? imageUrl,
      required int? userPoint,
      required int? voucherPoint,
      required BuildContext context}) async {
    EasyLoading.show();
    try {
      final voucherId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('voucher').doc().set(
          VoucherModel(
                  voucherId: voucherId,
                  nameVoucher: nameVoucher,
                  voucherDescription: voucherDescription,
                  imageVoucher: imageUrl,
                  point: voucherPoint)
              .toMap());
      final totalPoint = userPoint! - voucherPoint!;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(UserModel(point: totalPoint).toMap());
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
    EasyLoading.dismiss();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  fetchVoucher() {
    FirebaseFirestore.instance
        .collection('voucher')
        .where('voucherId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<VoucherModel> voucherList = [];
      for (var doc in snapshot.docs) {
        voucherList.add(VoucherModel(
            voucherId: doc['voucherId'],
            nameVoucher: doc['nameVoucher'],
            voucherDescription: doc['voucherDescription'],
            point: doc['point'],
            imageVoucher: doc['imageVoucher']));
      }

      emit(state.copyWith(listVoucher: voucherList));
    });
  }
}
