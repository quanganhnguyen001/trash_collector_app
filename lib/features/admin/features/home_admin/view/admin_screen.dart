// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/cubit/home_admin_cubit.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/widget/completed_trash_list_admin.dart';

import 'package:trash_collector_app/features/login/view/login_screen.dart';

import '../../../../../common/widget/alert_dialog_component.dart';
import '../../../../../theme/app_style.dart';
import '../../../../../theme/color_paletes.dart';
import '../widget/detail_trash_admin.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({
    super.key,
  });
  static const String routeName = '/AdminScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAdminCubit, HomeAdminState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  'Số lượng rác \ncần thu gom: ${state.trashListAdminPending.length}'),
              actions: [
                IconButton(
                    onPressed: () {
                      AlertDialogComponent.showCupertinoAlertDialog(
                          context: context,
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.remove('isAdmin');
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                LoginScreen.routeName, (route) => false);
                          },
                          title: 'Đăng xuất',
                          content: 'Bạn có chắc muốn đăng xuất ?');
                    },
                    icon: const Icon(Icons.logout))
              ],
              bottom: const TabBar(
                  indicatorColor: Colors.green,
                  labelColor: Colors.green,
                  tabs: [
                    Tab(
                      child: Text('Danh sách rác cần thu gom',
                          textAlign: TextAlign.center),
                    ),
                    Tab(
                      child: Text(
                        'Danh sách rác đã thu gom',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text('tét'),
                    )
                  ]),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ListView.builder(
                      itemCount: state.trashListAdminPending.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => DetaildTrashAdmin(
                                      trash: state.trashListAdminPending[index],
                                      onPressed: () {
                                        context
                                            .read<HomeAdminCubit>()
                                            .confirmCollected(
                                                context,
                                                state
                                                        .trashListAdminPending[
                                                            index]
                                                        .docId ??
                                                    '');
                                      },
                                    )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(16)),
                              child: ListTile(
                                leading: Image.network(
                                  state.trashListAdminPending[index]
                                          .trashImageUrl ??
                                      '',
                                  fit: BoxFit.cover,
                                  width: 100,
                                ),
                                title: Text(
                                    state.trashListAdminPending[index]
                                            .trashName ??
                                        '',
                                    style: AppTextStyle.H5(
                                        color: ColorPalettes.darkColor)),
                                subtitle: Text(
                                    state.trashListAdminPending[index]
                                            .typeTrash ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                trailing: Text(
                                    state.trashListAdminPending[index]
                                            .statusTrash ??
                                        '',
                                    style: const TextStyle(color: Colors.red)),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                CompletedTrashListAdmin(
                    trashListAdminCompleted: state.trashListAminCompleted),
                Container(
                  color: Colors.yellow,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
