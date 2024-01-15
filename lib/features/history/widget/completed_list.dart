import 'package:flutter/material.dart';

import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../../upload/model/trash_model.dart';

class CompletedList extends StatelessWidget {
  const CompletedList({super.key, required this.trashListCompleted});
  final List<TrashModel> trashListCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView.builder(
          itemCount: trashListCompleted.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) =>
                //         DetailTrashPending(trash: trashListPending[index])));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Image.network(
                          trashListCompleted[index].trashImageUrl ?? '',
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                        title: Text(trashListCompleted[index].trashName ?? '',
                            style: AppTextStyle.H5(
                                color: const Color.fromRGBO(60, 58, 54, 1))),
                        subtitle:
                            Text('SĐT: ${trashListCompleted[index].phone}',
                                style: const TextStyle(
                                  fontSize: 14,
                                )),
                        trailing: Text(
                            trashListCompleted[index].statusTrash == 'done'
                                ? 'Đã thu gom'
                                : '',
                            style: const TextStyle(color: Colors.green)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'Địa chỉ: ${trashListCompleted[index].locationTrash}',
                            style: const TextStyle(
                              fontSize: 14,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'Loại rác: ${trashListCompleted[index].typeTrash}',
                            style: const TextStyle(
                              fontSize: 14,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'Ngày thu gom: ${trashListCompleted[index].dateTrash?.substring(0, 11)}',
                            style: const TextStyle(
                              fontSize: 14,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'Thời gian thu gom: ${trashListCompleted[index].timeTrash?.substring(10, 15)}',
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
    );
  }
}
