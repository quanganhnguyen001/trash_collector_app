import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:trash_collector_app/common/widget/textfield_component.dart';
import 'package:trash_collector_app/gen/localization/l10n.dart';
import '../../../common/widget/button_component.dart';
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
  const UploadScreen({super.key});
  static const String routeName = '/UploadScreen';

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? _currentAddress;
  Position? _currentPosition;
  late Classifier _classifier;
  File? _selectedImageFile;
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  double _accuracy = 0.0;
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _wasteLabel = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _loadClassifier();
    super.initState();
  }

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
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}${place.subAdministrativeArea}, ${place.administrativeArea}';
        _controller.text = _currentAddress!;
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
                  Str.of(context).schedule_home_collection,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
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
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextFieldComponents(
                            hinText: Str.of(context).enter_trash_name,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Str.of(context).description,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextFieldComponents(
                            hinText: Str.of(context).enter_description,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Str.of(context).trash_image,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          showImageBottomSheet(
                              ontap1: () {},
                              ontap2: () {
                                _onPickPhoto(ImageSource.gallery);
                              });
                        },
                        child: (_selectedImageFile == null)
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12)),
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      Str.of(context).select_image,
                                      style: TextStyle(
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
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildResultView()),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Str.of(context).location,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextFieldComponents(
                            maxlines: 2,
                            controller: _controller,
                            rightIcon: InkWell(
                              onTap: () {
                                if (_controller.text.isEmpty) {
                                  _getCurrentPosition.call();
                                } else {
                                  return;
                                }
                              },
                              child: Icon(
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
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Str.of(context).select_date,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000));

                        if (dateTime != null) {
                          setState(() {
                            selectedDate = dateTime;
                          });
                        }
                      },
                      child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Str.of(context).select_time,
                          style: TextStyle(fontWeight: FontWeight.w500),
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
                            selectedTime = timeOfDay;
                          });
                        }
                      },
                      child: Text(
                        '${selectedTime.hour}:${selectedTime.minute}',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ButtonComponents(
                          onPressed: () {
                            // if (formKey.currentState!.validate()) {

                            // }
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
    );
  }

  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('Analyzing...');
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
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
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.65
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final wasteLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _wasteLabel = wasteLabel;
      _accuracy = accuracy;
    });
  }

  Widget _buildResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Failed to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _wasteLabel;
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
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
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                Str.of(context).accuracy,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                accuracyLabel,
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }

  showImageBottomSheet({
    required void Function() ontap1,
    required void Function() ontap2,
  }) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SizedBox(
              height: 150,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(children: [
                  InkWell(
                    onTap: ontap1,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.camera,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          Str.of(context).from_camera,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: ontap2,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.image,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          Str.of(context).from_gallery,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ));
        });
  }
}
