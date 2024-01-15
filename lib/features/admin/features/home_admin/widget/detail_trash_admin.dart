import 'package:flutter/material.dart';
import 'package:trash_collector_app/features/upload/model/trash_model.dart';

import '../../../../../common/widget/button_component.dart';
import '../../../../../common/widget/textfield_component.dart';
import '../../../../../gen/localization/l10n.dart';
import '../../../../../theme/app_style.dart';
import '../../../../../theme/color_paletes.dart';

class DetaildTrashAdmin extends StatelessWidget {
  const DetaildTrashAdmin(
      {super.key, required this.trash, required this.onPressed});

  final TrashModel trash;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorPalettes.darkColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text(
                  trash.trashName ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Str.of(context).trash_name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextFieldComponents(
                            readOnly: true,
                            value: trash.trashName,
                            hinText: Str.of(context).enter_trash_name,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Str.of(context).phone,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextFieldComponents(
                            readOnly: true,
                            value: trash.phone,
                            hinText: Str.of(context).enter_description,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Str.of(context).description,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextFieldComponents(
                            readOnly: true,
                            value: trash.trashDescription,
                            hinText: Str.of(context).enter_description,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Str.of(context).trash_image,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            trash.trashImageUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    Str.of(context).trash_type,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    trash.typeTrash ?? '',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    Str.of(context).accuracy,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    trash.accuracy ?? '',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Str.of(context).location,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextFieldComponents(
                            readOnly: true,
                            maxlines: 2,
                            value: trash.locationTrash,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Str.of(context).select_date,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Text(
                      trash.dateTrash?.substring(0, 11) ?? '',
                      style: const TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Str.of(context).select_time,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Text(
                      trash.timeTrash?.substring(10, 15) ?? '',
                      style: const TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Khối lượng rác',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: trash.weight,
                          onChanged: (value) {},
                        ),
                        Text('3 kg'),
                        Radio(
                          value: 2,
                          groupValue: trash.weight,
                          onChanged: (value) {},
                        ),
                        Text('5 kg'),
                        Radio(
                          value: 3,
                          groupValue: trash.weight,
                          onChanged: (value) {},
                        ),
                        Text('> 8 kg'),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ButtonComponents(
                          onPressed: onPressed,
                          height: 56,
                          radius: 16,
                          title: 'Xác nhận thu gom',
                          textStyle: AppTextStyle.buttonMedium(
                              color: ColorPalettes.whiteColor),
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
