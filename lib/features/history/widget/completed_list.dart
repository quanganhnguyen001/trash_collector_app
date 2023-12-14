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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: Image.network(
                      trashListCompleted[index].trashImageUrl ?? '',
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                    title: Text(trashListCompleted[index].trashName ?? '',
                        style: AppTextStyle.H5(color: ColorPalettes.darkColor)),
                    subtitle: Text(trashListCompleted[index].typeTrash ?? '',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                    trailing: Text(trashListCompleted[index].statusTrash ?? '',
                        style: const TextStyle(color: Colors.green)),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
