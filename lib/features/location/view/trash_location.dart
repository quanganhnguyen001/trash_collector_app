import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trash_collector_app/features/location/cubit/trash_location_cubit.dart';
import 'package:http/http.dart' as http;
import '../../../api_key.dart';

class TrashLocationScreen extends StatefulWidget {
  const TrashLocationScreen({super.key});
  static const String routeName = '/TrashLocationScreen';

  @override
  State<TrashLocationScreen> createState() => _TrashLocationScreenState();
}

class _TrashLocationScreenState extends State<TrashLocationScreen> {
  List listOfPoints = [];
  String? distance;
  String? duration;
  List<LatLng> points = const <LatLng>[];
  BitmapDescriptor makerIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController _googleMapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.0073516, 105.8221555),
    zoom: 15,
  );

  @override
  void initState() {
    customMarker();

    super.initState();
  }

  customMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/images/icon_bin.png')
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
        title: const Text('Địa điểm gần đây'),
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
                polylines: {
                  Polyline(
                      consumeTapEvents: true,
                      color: Colors.red,
                      polylineId: const PolylineId('_kPolyline'),
                      points: points,
                      width: 3)
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: {
                  Marker(
                      markerId: const MarkerId('1'),
                      icon: makerIcon,
                      infoWindow: InfoWindow(
                          title: 'Trường đại học thủy lợi',
                          onTap: () async {
                            Position position = await context
                                .read<TrashLocationCubit>()
                                .determinePosition();
                            getDirections(position.latitude, position.longitude,
                                21.0073516, 105.8221555);
                          }),
                      position: const LatLng(21.0073516, 105.8221555)),
                  Marker(
                      markerId: const MarkerId('2'),
                      icon: makerIcon,
                      infoWindow: InfoWindow(
                          title: 'Học viện ngân hàng',
                          onTap: () async {
                            Position position = await context
                                .read<TrashLocationCubit>()
                                .determinePosition();
                            getDirections(position.latitude, position.longitude,
                                21.0091314, 105.8262383);
                          }),
                      position: const LatLng(21.0091314, 105.8262383)),
                  Marker(
                      markerId: const MarkerId('3'),
                      icon: makerIcon,
                      infoWindow: InfoWindow(
                          title: 'Trường đại học công đoàn',
                          onTap: () async {
                            Position position = await context
                                .read<TrashLocationCubit>()
                                .determinePosition();
                            getDirections(position.latitude, position.longitude,
                                21.0097431, 105.8231375);
                          }),
                      position: const LatLng(21.0097431, 105.8231375)),
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
              duration != null && distance != null
                  ? Positioned(
                      left: 120,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                            'Distance: $distance km\n Duration: $duration min'),
                      ))
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  getDirections(
      double startLat, double startLng, double endLat, double endLng) async {
    EasyLoading.show();
    String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$openroute_api_key&start=$startLng,$startLat&end=$endLng,$endLat';
    var res = await http.get(Uri.parse(url));

    setState(() {
      var json = jsonDecode(res.body);
      listOfPoints = json['features'][0]['geometry']['coordinates'];
      points = listOfPoints
          .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
          .toList();
      distance =
          (json['features'][0]['properties']['summary']['distance'] / 1000)
              .toStringAsFixed(2);

      duration = (json['features'][0]['properties']['summary']['duration'] / 60)
          .toStringAsFixed(0);
    });
    EasyLoading.dismiss();
  }
}
