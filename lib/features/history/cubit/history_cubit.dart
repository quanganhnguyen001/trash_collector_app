import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trash_collector_app/features/upload/model/trash_model.dart';

import '../../auth/model/user_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit()
      : super(const HistoryState(trashListPending: [], trashListCompleted: []));

  fetchData() {
    fetchDataPending();
    fetchDataCompleted();
  }

  fetchDataPending() {
    FirebaseFirestore.instance
        .collection('trash')
        .where('trashId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('statusTrash', isEqualTo: 'pending')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<TrashModel> trashListPending = [];
      for (var doc in snapshot.docs) {
        trashListPending.add(TrashModel(
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

      emit(state.copyWith(trashListPending: trashListPending));
    });
  }

  fetchDataCompleted() {
    FirebaseFirestore.instance
        .collection('trash')
        .where('trashId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('statusTrash', isEqualTo: 'done')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<TrashModel> trashListCompleted = [];
      for (var doc in snapshot.docs) {
        trashListCompleted.add(TrashModel(
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

      emit(state.copyWith(trashListCompleted: trashListCompleted));
    });
  }

  deleteTrashPending(String docId, int userPoint) async {
    EasyLoading.show();
    try {
      await FirebaseFirestore.instance.collection('trash').doc(docId).delete();
      if (userPoint >= 1000) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(UserModel(
              point: userPoint - 1000,
            ).toMap());
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
  }

  Future editTrashPending(
      {required String docId,
      required String trashname,
      required String trashDescription,
      required String locationTrash,
      required String dateTrash,
      required String timeTrash,
      required BuildContext context}) async {
    EasyLoading.show();
    try {
      FirebaseFirestore.instance.collection('trash').doc(docId).update(
          TrashModel(
                  trashName: trashname,
                  trashDescription: trashDescription,
                  locationTrash: locationTrash,
                  dateTrash: dateTrash,
                  timeTrash: timeTrash)
              .toMap());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
    Navigator.of(context).pop();
  }
}
