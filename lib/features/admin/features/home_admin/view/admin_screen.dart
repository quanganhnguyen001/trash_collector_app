// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/cubit/home_admin_cubit.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/view/map_view_screen.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/widget/completed_trash_list_admin.dart';

import 'package:trash_collector_app/features/login/view/login_screen.dart';

import '../../../../../common/widget/alert_dialog_component.dart';
import '../../../../../gen/assets/assets.gen.dart';
import '../../../../../theme/app_style.dart';
import '../../../../../theme/color_paletes.dart';
import '../../../../upload/model/trash_model.dart';
import '../widget/detail_trash_admin.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({
    super.key,
  });
  static const String routeName = '/AdminScreen';

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String dropdownValue = 'Chọn khu vực';
  List<TrashModel> trashListAdminPendingFilter = [];

  fetchDataAdminPendingFilter() {
    FirebaseFirestore.instance
        .collection('trash')
        .where('statusTrash', isEqualTo: 'pending')
        .where('subAdministrativeArea', isEqualTo: dropdownValue)
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
        setState(() {
          trashListAdminPendingFilter = trashList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAdminCubit, HomeAdminState>(
      builder: (context, state) {
        String filterName() {
          if (dropdownValue == 'Chọn khu vực') {
            return 'Số lượng rác \ncần thu gom: ${state.trashListAdminPending.length}';
          } else if (dropdownValue == 'Tây Hồ') {
            return 'Số lượng rác \ncần thu gom tại khu vực Tây Hồ: ${trashListAdminPendingFilter.length}';
          } else if (dropdownValue == 'Cầu Giấy') {
            return 'Số lượng rác \ncần thu gom tại khu vực Cầu Giấy: ${trashListAdminPendingFilter.length}';
          } else {
            return 'Số lượng rác \ncần thu gom tại khu vực Đống Đa: ${trashListAdminPendingFilter.length}';
          }
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                filterName(),
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => HomeAdminCubit(),
                                child: MapViewScreen(),
                              )));
                    },
                    child: Assets.images.locationTrashIc.image(height: 40)),
                const SizedBox(
                  width: 10,
                ),
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
                  ]),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StreamBuilder(
                    stream: fetchDataAdminPendingFilter(),
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton(
                                value: dropdownValue,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Chọn khu vực'),
                                    value: 'Chọn khu vực',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Tây Hồ'),
                                    value: 'Tây Hồ',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Cầu Giấy'),
                                    value: 'Cầu Giấy',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Đống Đa'),
                                    value: 'Đống Đa',
                                  )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                }),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: dropdownValue == 'Chọn khu vực'
                                  ? ListView.builder(
                                      itemCount:
                                          state.trashListAdminPending.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder:
                                                        (ctx) =>
                                                            DetaildTrashAdmin(
                                                              trash: state
                                                                      .trashListAdminPending[
                                                                  index],
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        HomeAdminCubit>()
                                                                    .confirmCollected(
                                                                        context,
                                                                        state.trashListAdminPending[index].docId ??
                                                                            '');
                                                              },
                                                            )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: Container(
                                              height: 170,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    leading: Image.network(
                                                      state
                                                              .trashListAdminPending[
                                                                  index]
                                                              .trashImageUrl ??
                                                          '',
                                                      fit: BoxFit.cover,
                                                      width: 100,
                                                    ),
                                                    title: Text(
                                                        state
                                                                .trashListAdminPending[
                                                                    index]
                                                                .trashName ??
                                                            '',
                                                        style: AppTextStyle.H5(
                                                            color: const Color
                                                                .fromRGBO(60,
                                                                58, 54, 1))),
                                                    subtitle: Text(
                                                        'SĐT: ${state.trashListAdminPending[index].phone}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                    trailing: Text(
                                                        state
                                                                    .trashListAdminPending[
                                                                        index]
                                                                    .statusTrash ==
                                                                'pending'
                                                            ? 'Chờ thu gom'
                                                            : '',
                                                        style: const TextStyle(
                                                            color: Colors.red)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Địa chỉ: ${state.trashListAdminPending[index].locationTrash}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Loại rác: ${state.trashListAdminPending[index].typeTrash}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Ngày thu gom: ${state.trashListAdminPending[index].dateTrash?.substring(0, 11)}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Thời gian thu gom: ${state.trashListAdminPending[index].timeTrash?.substring(10, 15)}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : ListView.builder(
                                      itemCount:
                                          trashListAdminPendingFilter.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder:
                                                        (ctx) =>
                                                            DetaildTrashAdmin(
                                                              trash:
                                                                  trashListAdminPendingFilter[
                                                                      index],
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        HomeAdminCubit>()
                                                                    .confirmCollected(
                                                                        context,
                                                                        trashListAdminPendingFilter[index].docId ??
                                                                            '');
                                                              },
                                                            )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: Container(
                                              height: 170,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    leading: Image.network(
                                                      trashListAdminPendingFilter[
                                                                  index]
                                                              .trashImageUrl ??
                                                          '',
                                                      fit: BoxFit.cover,
                                                      width: 100,
                                                    ),
                                                    title: Text(
                                                        trashListAdminPendingFilter[
                                                                    index]
                                                                .trashName ??
                                                            '',
                                                        style: AppTextStyle.H5(
                                                            color: const Color
                                                                .fromRGBO(60,
                                                                58, 54, 1))),
                                                    subtitle: Text(
                                                        'SĐT: ${trashListAdminPendingFilter[index].phone}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                    trailing: Text(
                                                        trashListAdminPendingFilter[
                                                                        index]
                                                                    .statusTrash ==
                                                                'pending'
                                                            ? 'Chờ thu gom'
                                                            : '',
                                                        style: const TextStyle(
                                                            color: Colors.red)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Địa chỉ: ${trashListAdminPendingFilter[index].locationTrash}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Loại rác: ${trashListAdminPendingFilter[index].typeTrash}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Ngày thu gom: ${trashListAdminPendingFilter[index].dateTrash?.substring(0, 11)}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                        'Thời gian thu gom: ${trashListAdminPendingFilter[index].timeTrash?.substring(10, 15)}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                            ),
                          ),
                        ],
                      );
                    }),
                CompletedTrashListAdmin(
                    trashListAdminCompleted: state.trashListAminCompleted),
              ],
            ),
          ),
        );
      },
    );
  }
}
