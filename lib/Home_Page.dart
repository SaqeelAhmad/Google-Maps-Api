import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();

  // google Camera in Maps
  static final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(34.012752222197264, 71.50105327713736), zoom: 14);

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(34.012752222197264, 71.50105327713736),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(34.012752222197264, 71.50105327713736),
        infoWindow: InfoWindow(title: 'My Current Location')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(34.0127522221972641, 71.5247346683735),
        infoWindow: InfoWindow(title: 'Grand Trunk Road, Peshawar, Pakistan')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(34.12752222197265, 71.5247346683734),
        infoWindow: InfoWindow(title: 'Grand Trunk Road, Peshawar, Pakistan')),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(34.2127522221972642, 71.5247346683733),
        infoWindow: InfoWindow(title: 'Grand Trunk Road, Peshawar, Pakistan')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              // change maps type
              mapType: MapType.hybrid,
              markers: Set<Marker>.of(_marker),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,

              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              compassEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: GestureDetector(
                    onTap: _goToTheLake,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black)),
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Camera move to user Locations
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
