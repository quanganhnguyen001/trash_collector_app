// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:trash_collector_app/features/auth/model/user_model.dart';
import 'package:trash_collector_app/features/history/widget/detail_trash_pending.dart';
import 'package:trash_collector_app/features/history/widget/edit_trash.dart';
import 'package:trash_collector_app/features/upload/model/trash_model.dart';

import '../../../common/widget/alert_dialog_component.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../cubit/history_cubit.dart';

class PendingList extends StatelessWidget {
  const PendingList({
    super.key,
    required this.trashListPending,
    required this.userModel,
    required this.docId,
  });
  final List<TrashModel> trashListPending;
  final UserModel userModel;
  final String docId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView.builder(
          itemCount: trashListPending.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailTrashPending(trash: trashListPending[index])));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Slidable(
                  endActionPane:
                      ActionPane(motion: const StretchMotion(), children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(12),
                      onPressed: (value) async {
                        QuerySnapshot querySnapshot = await FirebaseFirestore
                            .instance
                            .collection('trash')
                            .get();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => HistoryCubit(),
                                  child: EditTrash(
                                    trash: trashListPending[index],
                                    docId: querySnapshot.docs[index].id,
                                  ),
                                )));
                      },
                      backgroundColor: Colors.green,
                      label: 'Edit',
                      icon: Icons.edit,
                    ),
                    SlidableAction(
                      borderRadius: BorderRadius.circular(12),
                      onPressed: (_) async {
                        AlertDialogComponent.showCupertinoAlertDialog(
                            context: context,
                            onPressed: () {
                              context.read<HistoryCubit>().deleteTrashPending(
                                  docId, userModel.point ?? 0);
                              Navigator.of(context).pop();
                            },
                            title: Str.of(context).delete_trash_user,
                            content: Str.of(context).delete_trash_content);
                      },
                      backgroundColor: Colors.red,
                      label: 'Delete',
                      icon: Icons.delete,
                    ),
                  ]),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: Image.network(
                        trashListPending[index].trashImageUrl ?? '',
                        fit: BoxFit.cover,
                        width: 100,
                      ),
                      title: Text(trashListPending[index].trashName ?? '',
                          style:
                              AppTextStyle.H5(color: ColorPalettes.darkColor)),
                      subtitle: Text(trashListPending[index].typeTrash ?? '',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      trailing: Text(trashListPending[index].statusTrash ?? '',
                          style: const TextStyle(color: Colors.red)),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
