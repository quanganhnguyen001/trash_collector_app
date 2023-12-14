// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:trash_collector_app/features/history/cubit/history_cubit.dart';
import 'package:trash_collector_app/features/history/widget/completed_list.dart';
import 'package:trash_collector_app/features/history/widget/pending_list.dart';

import '../../../common/widget/alert_dialog_component.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../widget/detail_trash_pending.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static const String routeName = '/HistoryScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
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
                    Tab(
                      child: Text(Str.of(context).voucher_list),
                    )
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
                      PendingList(
                        trashListPending: state.trashListPending,
                      ),
                      CompletedList(
                        trashListCompleted: state.trashListCompleted,
                      ),
                      Container(
                        color: Colors.yellow,
                      )
                    ]);
              },
            ),
          ),
        );
      },
    );
  }
}
