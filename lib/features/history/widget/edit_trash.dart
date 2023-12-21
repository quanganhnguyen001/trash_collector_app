import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/features/history/cubit/history_cubit.dart';
import 'package:trash_collector_app/features/upload/model/trash_model.dart';

import '../../../common/widget/button_component.dart';
import '../../../common/widget/current_location_widget.dart';
import '../../../common/widget/textfield_component.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';

class EditTrash extends StatefulWidget {
  const EditTrash({
    super.key,
    required this.trash,
    required this.docId,
  });

  final TrashModel trash;
  final String docId;

  @override
  State<EditTrash> createState() => _EditTrashState();
}

class _EditTrashState extends State<EditTrash> {
  final formKey = GlobalKey<FormState>();
  final trashNameController = TextEditingController();
  final trashDescriptionController = TextEditingController();
  final locationController = TextEditingController();
  @override
  void initState() {
    trashNameController.text = widget.trash.trashName ?? '';
    trashDescriptionController.text = widget.trash.trashDescription ?? '';
    locationController.text = widget.trash.locationTrash ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
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
                        Str.of(context).schedule_home_collection,
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFieldComponents(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return Str.of(context).valid_trash_name;
                                    }
                                    return null;
                                  },
                                  controller: trashNameController,
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
                                  Str.of(context).description,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFieldComponents(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return Str.of(context)
                                          .valid_trash_description;
                                    }
                                    return null;
                                  },
                                  controller: trashDescriptionController,
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () {
                                // ImageBottomSheet.showImageBottomSheet(
                                //     context: context,
                                //     ontap1: () {},
                                //     ontap2: () {
                                //       _onPickPhoto(
                                //           ImageSource.gallery, context);
                                //     });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    widget.trash.trashImageUrl ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: _buildResultView()),
                          const SizedBox(
                            height: 12,
                          ),
                          CurrentLocationWidget(
                            controller: locationController,
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000));
                              if (dateTime != null) {
                                setState(() {
                                  widget.trash.dateTrash = dateTime.toString();
                                });
                              }
                            },
                            child: Text(
                              widget.trash.dateTrash?.substring(0, 11) ?? '',
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 15),
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
                                Str.of(context).select_time,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.dial,
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (timeOfDay != null) {
                                setState(() {
                                  widget.trash.timeTrash = timeOfDay.toString();
                                });
                              }
                            },
                            child: Text(
                              widget.trash.timeTrash?.substring(10, 15) ?? '',
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ButtonComponents(
                                onPressed: () {
                                  context.read<HistoryCubit>().editTrashPending(
                                      docId: widget.docId,
                                      trashname: trashNameController.text,
                                      trashDescription:
                                          trashDescriptionController.text,
                                      locationTrash: locationController.text,
                                      dateTrash: widget.trash.dateTrash ?? '',
                                      timeTrash: widget.trash.timeTrash ?? '',
                                      context: context);
                                },
                                height: 56,
                                radius: 16,
                                title: Str.of(context).confirm,
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
          ),
        );
      },
    );
  }

  Widget _buildResultView() {
    return Row(
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
                widget.trash.typeTrash ?? '',
                style: const TextStyle(color: Colors.red, fontSize: 15),
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
                widget.trash.accuracy ?? '',
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }
}
