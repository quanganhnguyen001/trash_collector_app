import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trash_collector_app/features/admin/features/home_admin/cubit/home_admin_cubit.dart';
import 'package:trash_collector_app/gen/assets/assets.gen.dart';

import '../../../../../api_key.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  List listOfPoints = [];
  String? distance;
  String? duration;
  final Set<Marker> _makers = <Marker>{};
  List<LatLng> points = const <LatLng>[];
  BitmapDescriptor makerIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController _googleMapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.0875565, 105.8001873),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Địa điểm thu gom gần đây',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Position position =
                    await context.read<HomeAdminCubit>().determinePosition();

                if (position.latitude == 21.08755) {
                  setState(() {
                    _makers.add(Marker(
                        markerId: const MarkerId('id'),
                        infoWindow: InfoWindow(
                            title: '683 Đ. Lạc Long Quân, Tây Hồ, Hà Nội',
                            onTap: () async {
                              Position position = await context
                                  .read<HomeAdminCubit>()
                                  .determinePosition();
                              getDirections(position.latitude,
                                  position.longitude, 21.0760, 105.8127);
                            }),
                        position: LatLng(21.0760, 105.8127)));
                    _googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(21.0760, 105.8127), zoom: 16)));
                  });
                } else if (position.latitude == 21.0759867) {
                  setState(() {
                    _makers.add(Marker(
                        markerId: const MarkerId('id'),
                        infoWindow: InfoWindow(
                            title: '78D TT, Cầu Giấy, Hà Nội',
                            onTap: () async {
                              Position position = await context
                                  .read<HomeAdminCubit>()
                                  .determinePosition();
                              getDirections(position.latitude,
                                  position.longitude, 21.0367, 105.7750);
                            }),
                        position: LatLng(21.0367, 105.7750)));
                    _googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(21.0367, 105.7750), zoom: 16)));
                  });
                } else if (position.latitude == 21.007345) {
                  setState(() {
                    _makers.add(Marker(
                        markerId: const MarkerId('id'),
                        infoWindow: InfoWindow(
                            title:
                                'Tiến Bộ/26 Ngõ 4 - Hồ Đắc Di, Tổ 41+Tổ 42, Đống Đa, Hà Nội, Vietnam',
                            onTap: () async {
                              Position position = await context
                                  .read<HomeAdminCubit>()
                                  .determinePosition();
                              getDirections(position.latitude,
                                  position.longitude, 21.0105, 105.8254);
                            }),
                        position: LatLng(21.0105, 105.8254)));
                    _googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(21.0105, 105.8254), zoom: 16)));
                  });
                }
              },
              icon: Assets.images.markerIcon.image())
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: BlocBuilder<HomeAdminCubit, HomeAdminState>(
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
                markers: _makers,
                myLocationButtonEnabled: false,
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
                          .read<HomeAdminCubit>()
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
