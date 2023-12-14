import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trash_collector_app/features/location/cubit/trash_location_cubit.dart';

import '../../../gen/assets/assets.gen.dart';

class TrashLocationScreen extends StatefulWidget {
  const TrashLocationScreen({super.key});
  static const String routeName = '/TrashLocationScreen';

  @override
  State<TrashLocationScreen> createState() => _TrashLocationScreenState();
}

class _TrashLocationScreenState extends State<TrashLocationScreen> {
  BitmapDescriptor makerIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController _googleMapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.0073516, 105.8221555),
    zoom: 16,
  );

  @override
  void initState() {
    customMarker();
    // TODO: implement initState
    super.initState();
  }

  customMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/images/icon_bin.png')
        .then((value) {
      setState(() {
        makerIcon = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Địa điểm gần đây'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: BlocBuilder<TrashLocationCubit, TrashLocationState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: {
                  Marker(
                      markerId: MarkerId('1'),
                      icon: makerIcon,
                      position: LatLng(21.0073516, 105.8221555)),
                  Marker(
                      markerId: MarkerId('2'),
                      icon: makerIcon,
                      position: LatLng(21.0062696, 105.824553)),
                  Marker(
                      markerId: MarkerId('3'),
                      icon: makerIcon,
                      position: LatLng(21.0092606, 105.8180224)),
                },
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _googleMapController = controller;
                },
              ),
              Positioned(
                  bottom: 100,
                  right: 10,
                  child: GestureDetector(
                    onTap: () async {
                      Position position = await context
                          .read<TrashLocationCubit>()
                          .determinePosition();

                      _googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 16)));
                      setState(() {});
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        height: 50,
                        width: 50,
                        child: const Icon(
                          Icons.my_location,
                          size: 40,
                          color: Colors.blue,
                        )),
                  )),
            ],
          );
        },
      ),
    );
  }
}
