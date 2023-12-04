// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trash_collector_app/gen/localization/l10n.dart';

import '../../../common/widget/textfield_component.dart';

class CurrentLocationWidget extends StatefulWidget {
  const CurrentLocationWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CurrentLocationWidget> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocationWidget> {
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
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}${place.subAdministrativeArea}, ${place.administrativeArea}';
        widget.controller.text = _currentAddress!;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Str.of(context).location,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          TextFieldComponents(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Str.of(context).valid_location;
              }
              return null;
            },
            maxlines: 2,
            controller: widget.controller,
            rightIcon: InkWell(
              onTap: () {
                if (widget.controller.text.isEmpty) {
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
    );
  }
}
