import 'package:flutter/material.dart';

import '../../../../../theme/app_style.dart';
import '../../../../../theme/color_paletes.dart';
import '../../../../upload/model/trash_model.dart';

class CompletedTrashListAdmin extends StatelessWidget {
  final List<TrashModel> trashListAdminCompleted;

  const CompletedTrashListAdmin(
      {super.key, required this.trashListAdminCompleted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView.builder(
          itemCount: trashListAdminCompleted.length,
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: Image.network(
                      trashListAdminCompleted[index].trashImageUrl ?? '',
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                    title: Text(trashListAdminCompleted[index].trashName ?? '',
                        style: AppTextStyle.H5(color: ColorPalettes.darkColor)),
                    subtitle: Text(
                        trashListAdminCompleted[index].typeTrash ?? '',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                    trailing: Text(
                        trashListAdminCompleted[index].statusTrash ?? '',
                        style: const TextStyle(color: Colors.green)),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
