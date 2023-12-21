// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:trash_collector_app/features/auth/model/user_model.dart';

import 'package:trash_collector_app/features/history/cubit/history_cubit.dart';
import 'package:trash_collector_app/features/history/widget/completed_list.dart';
import 'package:trash_collector_app/features/history/widget/pending_list.dart';

import '../../../common/widget/alert_dialog_component.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../widget/detail_trash_pending.dart';
import '../widget/edit_trash.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.userModel});
  static const String routeName = '/HistoryScreen';
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  indicatorColor: Colors.green,
                  labelColor: Colors.green,
                  tabs: [
                    Tab(
                      child: Text(Str.of(context).trash_wait),
                    ),
                    Tab(
                      child: Text(
                        Str.of(context).success_collect,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
              leading: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ),
              title: Text(
                Str.of(context).history_collect,
                maxLines: 1,
                style: AppTextStyle.H4(),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: ListView.builder(
                            itemCount: state.trashListPending.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailTrashPending(
                                          trash:
                                              state.trashListPending[index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            onPressed: (value) async {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              BlocProvider(
                                                                create: (context) =>
                                                                    HistoryCubit(),
                                                                child: EditTrash(
                                                                    trash: state
                                                                            .trashListPending[
                                                                        index],
                                                                    docId: state
                                                                            .trashListPending[index]
                                                                            .docId ??
                                                                        ''),
                                                              )));
                                            },
                                            backgroundColor: Colors.green,
                                            label: 'Edit',
                                            icon: Icons.edit,
                                          ),
                                          SlidableAction(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            onPressed: (_) async {
                                              AlertDialogComponent
                                                  .showCupertinoAlertDialog(
                                                      context: context,
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                HistoryCubit>()
                                                            .deleteTrashPending(
                                                                state
                                                                        .trashListPending[
                                                                            index]
                                                                        .docId ??
                                                                    '',
                                                                userModel
                                                                        .point ??
                                                                    0);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      title: Str.of(context)
                                                          .delete_trash_user,
                                                      content: Str.of(context)
                                                          .delete_trash_content);
                                            },
                                            backgroundColor: Colors.red,
                                            label: 'Delete',
                                            icon: Icons.delete,
                                          ),
                                        ]),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: ListTile(
                                        leading: Image.network(
                                          state.trashListPending[index]
                                                  .trashImageUrl ??
                                              '',
                                          fit: BoxFit.cover,
                                          width: 100,
                                        ),
                                        title: Text(
                                            state.trashListPending[index]
                                                    .trashName ??
                                                '',
                                            style: AppTextStyle.H5(
                                                color:
                                                    ColorPalettes.darkColor)),
                                        subtitle: Text(
                                            state.trashListPending[index]
                                                    .typeTrash ??
                                                '',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey)),
                                        trailing: Text(
                                            state.trashListPending[index]
                                                    .statusTrash ??
                                                '',
                                            style: const TextStyle(
                                                color: Colors.red)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      CompletedList(
                        trashListCompleted: state.trashListCompleted,
                      ),
                    ]);
              },
            ),
          ),
        );
      },
    );
  }
}
