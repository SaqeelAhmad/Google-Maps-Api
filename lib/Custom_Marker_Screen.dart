import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui'as ui;


class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  
  final Completer<GoogleMapController> _comparable = Completer() ;
Uint8List? markerImage;

 Future<Uint8List> getBytesFromAssets(String path, int width)async{
   ByteData data = await rootBundle.load(path);
   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
   ui.FrameInfo fi = await codec.getNextFrame();
   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
 }


  List <String> images =[
    "assets/images/shop.png",
    "assets/images/shop.png",
    "assets/images/shop.png",
    "assets/images/shop.png",
    "assets/images/shop.png",
    "assets/images/shop.png"
  ];
  
  final List<Marker> _marker= <Marker>[];


  final List<LatLng> _latLang = <LatLng>[
    LatLng(34.012752222197264, 71.50105327713736),
    LatLng(33.5889, 71.4429),
    LatLng(34.22197264, 71.32771373),
    LatLng(31.0127522264, 71.501053272),
    LatLng(32.052222197264, 74.375),
    LatLng(37.0127522221, 71.501057137),
  ];


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.01275222219, 71.5010532771),
    zoom: 15
  );


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  loadData () async {
    for (int i=0; i< images.length; i++){
       final Uint8List merkericon =await getBytesFromAssets(images[i], 100);
      _marker.add(Marker(markerId: MarkerId(i.toString()),
          position: _latLang[i],
          icon: BitmapDescriptor.fromBytes(merkericon),
         // icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'This is title marker '+i.toString(),
          )
      ));
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: GoogleMap(
        // change maps type
        mapType: MapType.normal,
       myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController  controller){
          _comparable.complete(controller);
        },
      ),
    ),
    );
  }
}
