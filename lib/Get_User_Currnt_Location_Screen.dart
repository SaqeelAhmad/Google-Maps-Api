import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrntLocationScreen extends StatefulWidget {
  const GetUserCurrntLocationScreen({Key? key}) : super(key: key);

  @override
  State<GetUserCurrntLocationScreen> createState() =>
      _GetUserCurrntLocationScreenState();
}

class _GetUserCurrntLocationScreenState
    extends State<GetUserCurrntLocationScreen> {
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
  List<Marker> _list = [
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(34.0078616615095, 71.52473435166837),
        infoWindow: InfoWindow(title: 'Grand Trunk Road, Peshawar, Pakistan')),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error : " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  loadData(){
    getUserCurrentLocation().then((value) async {
      print("My current location.");
      print(value.latitude.toString()+" "+value.longitude.toString());
      _marker.add(Marker(markerId: MarkerId("2"),
          position: LatLng(value.latitude,value.longitude),
          infoWindow: InfoWindow(
              title: "My Current Location."
          )
      ));

      CameraPosition cameraPosition = CameraPosition(
          zoom: 19.151926040649414,
          bearing: 192.8334901395799,
          target: LatLng(value.latitude,value.longitude) );

      final GoogleMapController controller =await  _controller.future ;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });

    });
  }

  final Set<Polyline> _polyline = {};


  List<LatLng> latlng= [
    LatLng(34.00807894915122, 71.50827166724038),
    LatLng(21.422505919993938, 39.82615679964658),//Makkah Saudi Arabia
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  String currentLatitude="" , currentLongitude = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              markers: Set<Marker>.of(_marker),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
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
  void _goToTheLake(){getUserCurrentLocation().then((value) async {
  print("My current location.");

  print(value.latitude.toString() + " " + value.longitude.toString());
  _marker.add(Marker(
  markerId: MarkerId("2"),
  position: LatLng(value.latitude, value.longitude),
  infoWindow: InfoWindow(title: "My Current Location.")));

  CameraPosition cameraPosition = CameraPosition(
  zoom: 19.151926040649414,
  bearing: 192.8334901395799,
  target: LatLng(value.latitude, value.longitude));

  final GoogleMapController controller = await _controller.future;
  controller
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  setState(() {
    currentLatitude = value.latitude.toString();
    currentLongitude = value.longitude.toString();
    print(currentLatitude);
  });
  });}
}
