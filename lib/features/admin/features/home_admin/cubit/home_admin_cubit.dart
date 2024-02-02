import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../upload/model/trash_model.dart';

part 'home_admin_state.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit()
      : super(const HomeAdminState(
            trashListAdminPending: [], trashListAminCompleted: []));

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
            phone: doc['phone'],
            weight: doc['weight'],
            subAdministrativeArea: doc['subAdministrativeArea']));
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
            phone: doc['phone'],
            weight: doc['weight'],
            subAdministrativeArea: doc['subAdministrativeArea']));
      }

      emit(state.copyWith(trashListAminCompleted: trashList));
    });
  }

  Future<void> confirmCollected(BuildContext context, String docId) async {
    EasyLoading.show();
    try {
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

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
