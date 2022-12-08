import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PolylineSceen extends StatefulWidget {
  const PolylineSceen({Key? key}) : super(key: key);

  @override
  State<PolylineSceen> createState() => _PolylineSceenState();
}

class _PolylineSceenState extends State<PolylineSceen> {

  Completer<GoogleMapController> _controller =Completer();
  CameraPosition _KGooglePlex= CameraPosition(
      target: LatLng(34.00807894915122, 71.50827166724038),
  zoom: 15
  );


  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};

  
  List<LatLng> latlng= [
    LatLng(34.00807894915122, 71.50827166724038),
    LatLng(21.422505919993938, 39.82615679964658),//Makkah Saudi Arabia
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0 ; i < latlng.length; i++){
      _marker.add(
        Marker(markerId: MarkerId(i.toString()),
          position: latlng[i],
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
           // title: 'Kohat',
            //snippet: "Kohat"

          )
        )
      );
      setState(() {
        
      });
      _polyline.add (
        Polyline(polylineId: PolylineId("1"),
            points: latlng,
          color: Colors.blueAccent

        ),
      );
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Polyline"),),
      body: GoogleMap(
        initialCameraPosition: _KGooglePlex,
      mapType: MapType.normal,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: _marker,
        polylines: _polyline,

        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },

      ),
    );
  }
}
