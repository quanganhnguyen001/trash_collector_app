import 'package:flutter/material.dart';

import 'package:trash_collector_app/features/admin/features/home_admin/widget/detail_trash_admin.dart';

import '../../../../../theme/app_style.dart';
import '../../../../../theme/color_paletes.dart';
import '../../../../upload/model/trash_model.dart';

class TrashListAdmin extends StatelessWidget {
  const TrashListAdmin(
      {super.key, required this.trashList, required this.onPressed});
  final List<TrashModel> trashList;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView.builder(
          itemCount: trashList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetaildTrashAdmin(
                          trash: trashList[index],
                          onPressed: () {},
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
                      trashList[index].trashImageUrl ?? '',
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                    title: Text(trashList[index].trashName ?? '',
                        style: AppTextStyle.H5(color: ColorPalettes.darkColor)),
                    subtitle: Text(trashList[index].typeTrash ?? '',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                    trailing: Text(trashList[index].statusTrash ?? '',
                        style: const TextStyle(color: Colors.red)),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
