import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:trash_collector_app/common/widget/textfield_component.dart';
import 'package:trash_collector_app/features/auth/model/user_model.dart';
import 'package:trash_collector_app/features/upload/cubit/upload_cubit.dart';

import 'package:trash_collector_app/features/upload/widget/image_bottom_sheet.dart';
import 'package:trash_collector_app/gen/localization/l10n.dart';
import '../../../common/widget/button_component.dart';
import '../../../common/widget/current_location_widget.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../model/classifier.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key, required this.userModel});
  static const String routeName = '/UploadScreen';
  final UserModel userModel;

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final formKey = GlobalKey<FormState>();
  late Classifier _classifier;
  File? _selectedImageFile;
  final picker = ImagePicker();
  double _accuracy = 0.0;
  int? selectedValue;
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _wasteLabel = '';
  TimeOfDay selectedTime = TimeOfDay.now();
  var title = '';
  var accuracyLabel = '';
  Placemark? place;
  @override
  void initState() {
    context.read<UploadCubit>().phoneController.text =
        widget.userModel.phone ?? '';
    context.read<UploadCubit>().trashNameController.text =
        widget.userModel.name ?? '';
    _loadClassifier();
    super.initState();
  }

  String? _currentAddress;
  Position? _currentPosition;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place?.street}, ${place?.subLocality}${place?.subAdministrativeArea}, ${place?.administrativeArea}';
        context.read<UploadCubit>().locationController.text = _currentAddress!;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCubit, UploadState>(
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
                                      return 'Vui lòng nhập tên';
                                    }
                                    return null;
                                  },
                                  controller: context
                                      .read<UploadCubit>()
                                      .trashNameController,
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFieldComponents(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return Str.of(context).valid_phone;
                                    }
                                    return null;
                                  },
                                  controller: context
                                      .read<UploadCubit>()
                                      .phoneController,
                                  hinText: 'Nhập số điện thoại',
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
                                  controller: context
                                      .read<UploadCubit>()
                                      .trashDescriptionController,
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
                                ImageBottomSheet.showImageBottomSheet(
                                    context: context,
                                    ontap1: () {},
                                    ontap2: () {
                                      _onPickPhoto(
                                          ImageSource.gallery, context);
                                    });
                              },
                              child: (_selectedImageFile == null)
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            Str.of(context).select_image,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Icon(
                                            Icons.camera_alt_rounded,
                                            size: 80.0,
                                            color: Colors.grey.shade700,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          _selectedImageFile!,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Str.of(context).location,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                TextFieldComponents(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return Str.of(context).valid_location;
                                    }
                                    return null;
                                  },
                                  maxlines: 2,
                                  controller: context
                                      .read<UploadCubit>()
                                      .locationController,
                                  rightIcon: InkWell(
                                    onTap: () {
                                      if (context
                                          .read<UploadCubit>()
                                          .locationController
                                          .text
                                          .isEmpty) {
                                        _getCurrentPosition.call();
                                      } else {
                                        return;
                                      }
                                    },
                                    child: const Icon(
                                      Icons.location_on,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                  hinText: Str.of(context).enter_location,
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<UploadCubit>().selectDate(context);
                            },
                            child: Text(
                              '${state.selectedDate.day}/${state.selectedDate.month}/${state.selectedDate.year}',
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
                            onTap: () {
                              context.read<UploadCubit>().selectTime(context);
                            },
                            child: Text(
                              '${state.selectedTime.hour}:${state.selectedTime.minute}',
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
                                'Khối lượng rác',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                              ),
                              Text('3 kg'),
                              Radio(
                                value: 2,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                              ),
                              Text('5 kg'),
                              Radio(
                                value: 3,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
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
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (_selectedImageFile == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.white,
                                              content: Text(
                                                Str.of(context).valid_image,
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              )));
                                    } else {
                                      context.read<UploadCubit>().uploadTrash(
                                          userPoint: widget.userModel.point,
                                          typeTrash: title,
                                          accuracy: accuracyLabel,
                                          dateTrash:
                                              state.selectedDate.toString(),
                                          timeTrash:
                                              state.selectedTime.toString(),
                                          file: _selectedImageFile,
                                          context: context,
                                          weight: selectedValue,
                                          subAdministrativeArea:
                                              place?.subAdministrativeArea);
                                    }
                                  }
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

  void _onPickPhoto(ImageSource source, BuildContext ctx) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);

    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.65
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final wasteLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    setState(() {
      _resultStatus = result;
      _wasteLabel = wasteLabel;
      _accuracy = accuracy;
    });
  }

  Widget _buildResultView() {
    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Failed to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _wasteLabel;
    } else {
      title = '';
    }
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = ': ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

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
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.red, fontSize: 15),
                ),
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
                accuracyLabel,
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }
}
