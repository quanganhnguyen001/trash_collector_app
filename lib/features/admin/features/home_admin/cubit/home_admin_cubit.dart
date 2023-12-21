import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trash_collector_app/features/auth/model/user_model.dart';

import '../../../../../gen/assets/assets.gen.dart';
import '../../../../../theme/app_style.dart';
import '../../../../upload/model/trash_model.dart';

part 'home_admin_state.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit()
      : super(const HomeAdminState(
            trashListAdminPending: [], trashListAminCompleted: []));
  String id = '';

  fetchDataAdmin() {
    fetchDataAdminPending();
    fetchDataAdminCompleted();
  }

  fetchDataAdminPending() {
    FirebaseFirestore.instance
        .collection('trash')
        .where('statusTrash', isEqualTo: 'pending')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<TrashModel> trashList = [];
      for (var doc in snapshot.docs) {
        trashList.add(TrashModel(
          trashId: doc['trashId'],
          trashName: doc['trashName'],
          trashDescription: doc['trashDescription'],
          trashImageUrl: doc['trashImageUrl'],
          typeTrash: doc['typeTrash'],
          accuracy: doc['accuracy'],
          locationTrash: doc['locationTrash'],
          dateTrash: doc['dateTrash'],
          timeTrash: doc['timeTrash'],
          statusTrash: doc['statusTrash'],
          docId: doc.id,
        ));
      }

      emit(state.copyWith(trashListAdminPending: trashList));
    });
  }

  fetchDataAdminCompleted() {
    FirebaseFirestore.instance
        .collection('trash')
        .where('statusTrash', isEqualTo: 'done')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<TrashModel> trashList = [];
      for (var doc in snapshot.docs) {
        trashList.add(TrashModel(
          trashId: doc['trashId'],
          trashName: doc['trashName'],
          trashDescription: doc['trashDescription'],
          trashImageUrl: doc['trashImageUrl'],
          typeTrash: doc['typeTrash'],
          accuracy: doc['accuracy'],
          locationTrash: doc['locationTrash'],
          dateTrash: doc['dateTrash'],
          timeTrash: doc['timeTrash'],
          statusTrash: doc['statusTrash'],
        ));
      }

      emit(state.copyWith(trashListAminCompleted: trashList));
    });
  }

  Future<void> confirmCollected(BuildContext context, String docId) async {
    EasyLoading.show();
    try {
      print(docId);
      await FirebaseFirestore.instance
          .collection('trash')
          .doc(docId)
          .update(TrashModel(statusTrash: 'done').toMap());

      // await FirebaseFirestore.instance
      //     .collection('voucher')
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .update(UserModel(point: ).toMap());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
