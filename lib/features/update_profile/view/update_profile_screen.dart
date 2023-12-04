import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trash_collector_app/common/widget/current_location_widget.dart';
import 'package:trash_collector_app/features/upload/widget/image_bottom_sheet.dart';

import '../../../common/widget/button_component.dart';
import '../../../common/widget/header_button_component.dart';
import '../../../common/widget/textfield_component.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../cubit/update_profile_cubit.dart';
import '../model/update_profile_arg.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.arg});
  static const String routeName = '/UpdateProfileScreen';
  final UpdateProfileArg arg;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    context.read<UpdateProfileCubit>().nameController.text = widget.arg.name;
    context.read<UpdateProfileCubit>().phoneController.text = widget.arg.phone;
    context.read<UpdateProfileCubit>().locationController.text =
        widget.arg.location;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: HeaderButtonComponents(
            padding: const EdgeInsets.only(left: 5),
            icon: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
        ),
        title: Text(
          Str.of(context).update_info,
          style: AppTextStyle.H4(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        InkWell(
                            onTap: () {
                              ImageBottomSheet.showImageBottomSheet(
                                  context: context,
                                  ontap1: () {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .selectImage(ImageSource.camera);
                                  },
                                  ontap2: () {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .selectImage(ImageSource.gallery);
                                  });
                            },
                            child: state.selectedImage == null
                                ? Center(
                                    child: Container(
                                        height: 155,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 3,
                                                color: ColorPalettes
                                                    .secondaryColor)),
                                        child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                widget.arg.imageUrl))),
                                  )
                                : Container(
                                    height: 155,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3,
                                            color:
                                                ColorPalettes.secondaryColor)),
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(File(
                                          state.selectedImage?.path ?? '')),
                                    ))),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Str.of(context).name,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              TextFieldComponents(
                                controller: context
                                    .read<UpdateProfileCubit>()
                                    .nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return Str.of(context).valid_name;
                                  }
                                  return null;
                                },
                                height: 53,
                                padding: const EdgeInsets.only(left: 16),
                                hinText: Str.of(context).username,
                                hintStyle: AppTextStyle.paragraphMedium(
                                    color: ColorPalettes.darkgrayColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Str.of(context).phone,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              TextFieldComponents(
                                controller: context
                                    .read<UpdateProfileCubit>()
                                    .phoneController,
                                height: 53,
                                padding: const EdgeInsets.only(left: 16),
                                hinText: Str.of(context).update_phone,
                                hintStyle: AppTextStyle.paragraphMedium(
                                    color: ColorPalettes.darkgrayColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CurrentLocationWidget(
                            controller: context
                                .read<UpdateProfileCubit>()
                                .locationController),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ButtonComponents(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (state.selectedImage != null) {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .updateProfileWithImage(
                                            context, state.selectedImage);
                                  } else {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .updateProfile(context);
                                  }
                                }
                              },
                              height: 56,
                              radius: 16,
                              title: Str.of(context).save,
                              textStyle: AppTextStyle.buttonMedium(
                                  color: ColorPalettes.whiteColor),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
