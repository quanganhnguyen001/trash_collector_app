// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trash_collector_app/features/auth/model/user_model.dart';

import 'package:trash_collector_app/features/upload/model/trash_model.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit()
      : super(UploadState(
            selectedDate: DateTime.now(), selectedTime: TimeOfDay.now()));
  final trashNameController = TextEditingController();
  final trashDescriptionController = TextEditingController();
  final locationController = TextEditingController();

  selectDate(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));
    if (dateTime != null) {
      emit(state.copyWith(selectedDate: dateTime));
    }
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: TimeOfDay.now());
    if (timeOfDay != null) {
      emit(state.copyWith(selectedTime: timeOfDay));
    }
  }

  uploadTrash(
      {required String typeTrash,
      required String accuracy,
      required String dateTrash,
      required String timeTrash,
      required File? file,
      required int? userPoint,
      required BuildContext context}) async {
    EasyLoading.show();
    try {
      final trashId = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance
          .ref()
          .child('trashImage')
          .child('/$trashId/${DateTime.now().millisecondsSinceEpoch}');
      if (file != null) {
        await ref.putFile(File(file.path));
      }

      String imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance.collection('trash').doc().set(TrashModel(
            trashId: FirebaseAuth.instance.currentUser!.uid,
            trashName: trashNameController.text,
            trashDescription: trashDescriptionController.text,
            trashImageUrl: imageUrl,
            typeTrash: typeTrash,
            accuracy: accuracy,
            locationTrash: locationController.text,
            dateTrash: dateTrash,
            timeTrash: timeTrash,
            statusTrash: 'pending',
          ).toMap());
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(UserModel(
            point: userPoint! + 1000,
          ).toMap());
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
    EasyLoading.dismiss();
    Navigator.of(context).pop();
  }
}
